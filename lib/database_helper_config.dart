class DatabaseHelperConfig {
  final int databaseVersion;
  final String databaseFileName;
  final String tableName;
  final String tableSchema;

  DatabaseHelperConfig({
    this.databaseVersion = 1,
    this.databaseFileName = 'database.db',
    this.tableName = 'entries',
    this.tableSchema = 'id INTEGER PRIMARY KEY, content TEXT',
  });
}