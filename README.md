# SQL Transformer

Useful transformers to be used with [Dart's streams](https://dart.dev/tutorials/language/streams) when reading SQL files.

At the time of this writing, there are only two available SQL transformers
1. `SqlSplitterTransformer`. Splits a stream of SQL statements into a stream of individual SQL statements.
2. `SqlValuesTransformer`. Replaces all values in a stream of SQL statements with a question mark.
3. There is also `SqlCommentTransformer`, which is used to remove all comments from a stream of SQL statements.


## Usage

### Replacing / setting values to variables in SQL files
To do this, you must use the `SqlValuesTransformer` class, and pass as an argument a map with the values you'd like to replace.

For using and replacing variables with the transformer, you must use the `SqlValuesTransformer` class, and pass as an argument a map with the values you'd like to replace.
For this to work, you must use the colon in front of the variable name in the SQL file.

**Example SQL file:**

```sql
select * from users where name = :name and last_name = :last_name;
```

**Example Dart code:**

```dart

import 'dart:convert';
import 'dart:io';

import 'package:sql_transformer/sql_transformer.dart';

void main(List<String> args) async {
  final file = File('get_users_and_purchases.sql');
  // The values you'd like to replace in the SQL file.
  final values = {'name': 'John', 'last_name': 'Doe'};

  final lines = utf8.decoder
      .bind(file.openRead())
      .transform(const SqlValuesTransformer(values));
  }
  

```

### Removing comments from SQL file

```dart
import 'dart:convert';
import 'dart:io';

import 'package:sql_transformer/sql_transformer.dart';

void main(List<String> args) async {
  // Remove comments from SQL file
  final sqlFileWithoutComments = utf8.decoder
      .bind(file.openRead())
      .transform(const SqlCommentTransformer());
}
```

### Splitting SQL file into individual SQL statements

```dart
import 'dart:convert';
import 'dart:io';

import 'package:sql_transformer/sql_transformer.dart';

void main(List<String> args) async {
  // Split the SQL statements in the SQL file into individual SQL statements.
  var file = File('get_users_and_purchases.sql');
  var lines = utf8.decoder
      .bind(file.openRead())
      .transform(const SqlSplitterTransformer());
}
```

### You can also chain the transformers together

```dart
import 'dart:convert';
import 'dart:io';

import 'package:sql_transformer/sql_transformer.dart';

void main(List<String> args) async {
  var file = File('example.sql');
  var lines = utf8.decoder
      .bind(file.openRead())
      .transform(const SqlCommentTransformer())
      .transform(const SqlSplitterTransformer())
      .transform(const SqlValuesTransformer({'name': 'John', 'last_name': 'Doe'}));
}
```

# License

BSD 3-Clause License (see LICENSE file)