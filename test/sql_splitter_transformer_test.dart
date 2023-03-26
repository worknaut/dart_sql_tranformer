import 'package:sql_transformer/sql_transformer.dart';
import 'package:test/test.dart';
import 'dart:async';

void main() {
  group('SqlSplitterTransformer', () {
    test('should split SQL statements', () async {
      final sqlTransformer = SqlSplitterTransformer();
      final sqlStatements = [
        'SELECT * FROM users;',
        'SELECT * FROM orders WHERE user_id = 123;',
        'INSERT INTO users (name, email) VALUES ("John", "john@example.com");',
      ];
      final expectedResults = [
        'SELECT * FROM users;',
        'SELECT * FROM orders WHERE user_id = 123;',
        'INSERT INTO users (name, email) VALUES ("John", "john@example.com");',
      ];
      final actualResults = await Stream.fromIterable(sqlStatements)
          .transform(sqlTransformer)
          .toList();
      expect(actualResults, expectedResults);
    });

    test('should handle empty statements', () async {
      final sqlTransformer = SqlSplitterTransformer();
      final sqlStatements = [
        'SELECT * FROM users;',
        '',
        'SELECT * FROM orders WHERE user_id = 123;',
      ];
      final expectedResults = [
        'SELECT * FROM users;',
        'SELECT * FROM orders WHERE user_id = 123;',
      ];
      final actualResults = await Stream.fromIterable(sqlStatements)
          .transform(sqlTransformer)
          .toList();
      expect(actualResults, expectedResults);
    });
  });
}
