import 'package:databases/database_helper.dart';

class EntryModel implements DatabaseModel {
  final int id;
  final String content;

  EntryModel({
    required this.id,
    required this.content,
  });

  /// Convert this instance to a map
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'content': content
    };
  }

  /// Convert this instance to an object
  static EntryModel fromMap(Map<String, Object?> map) =>
      EntryModel(
        id: map['id'] as int,
        content: map['content'] as String
      );
}