import 'dart:async';
import 'package:test/test.dart';
import 'package:sql_transformer/sql_transformer.dart';

void main() {
  group('SqlValuesTransformer', () {
    test('should replace placeholders with values', () async {
      final values = {'id': 123, 'name': 'John', 'email': 'john@example.com'};
      final sqlTransformer = SqlValuesTransformer(values);
      final inputSql = 'SELECT * FROM users WHERE id = :id AND email = :email;';
      final expectedSql =
          'SELECT * FROM users WHERE id = 123 AND email = \'john@example.com\';';
      final actualSql =
      await Stream.value(inputSql).transform(sqlTransformer).first;
      expect(actualSql, expectedSql);
    });

    test('should handle non-string values', () async {
      final values = {'id': 123, 'score': 4.5};
      final sqlTransformer = SqlValuesTransformer(values);
      final inputSql = 'UPDATE users SET score = :score WHERE id = :id;';
      final expectedSql = 'UPDATE users SET score = 4.5 WHERE id = 123;';
      final actualSql =
      await Stream.value(inputSql).transform(sqlTransformer).first;
      expect(actualSql, expectedSql);
    });

    test('should handle missing values', () async {
      final values = {'id': 123, 'name': 'John'};
      final sqlTransformer = SqlValuesTransformer(values);
      final inputSql = 'SELECT * FROM users WHERE id = :id AND email = :email;';
      final expectedSql =
          'SELECT * FROM users WHERE id = 123 AND email = :email;';
      final actualSql =
      await Stream.value(inputSql).transform(sqlTransformer).first;
      expect(actualSql, expectedSql);
    });
  });
}