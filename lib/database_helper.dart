import 'dart:async';

import 'package:databases/database_helper_config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A very simple class that we recognize as SQLite-compatible
abstract class DatabaseModel {
  Map<String, Object?> toMap();
}

/// A very simple helper class to manage local SQLite databases.
/// It should be adjusted as needed.
class DatabaseHelper<T> {
  final DatabaseHelperConfig config;

  DatabaseHelper(this.config);

  /// Open the database for usage
  Future<Database> initialize() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, config.databaseFileName),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE ${config.tableName}(${config.tableSchema})",
        );
      },
      version: config.databaseVersion,
    );
  }

  /// Insert a model into the database
  Future<int> insert(DatabaseModel model) async {
    final Database db = await initialize();
    return await db.insert(
      config.tableName,
      model.toMap(),
    );
  }

  /// Retrieve all models from the database.
  /// Specify a function to construct an Object from the returned JSON.
  Future<List<DatabaseModel>> retrieve(DatabaseModel Function(Map<String, Object?>) mapFunc) async {
    final Database db = await initialize();
    final List<Map<String, Object?>> queryResult = await db.query(config.tableName);
    return queryResult.map((e) => mapFunc(e)).toList();
  }

  /// Delete an entry where a variable matches a value
  Future deleteWhere(String variable, Object value) async {
    final db = await initialize();
    await db.delete(
      config.tableName,
      where: "$variable = ?",
      whereArgs: [value],
    );
  }

  /// Delete all rows
  Future deleteAll() async {
    final db = await initialize();
    await db.delete(config.tableName);
  }
}