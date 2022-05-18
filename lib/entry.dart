import 'package:databases/database_helper.dart';

class EntryModel implements DatabaseModel {
  final int id;
  final int age;

  EntryModel({
    required this.id,
    required this.age,
  });

  /// Convert this instance to a map
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'age': age
    };
  }

  /// Convert this instance to an object
  static EntryModel fromMap(Map<String, Object?> map) =>
      EntryModel(
        id: map['id'] as int,
        age: map['age'] as int
      );
}