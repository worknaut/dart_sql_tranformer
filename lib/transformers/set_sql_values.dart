import 'dart:async';

class SetSQLValues extends StreamTransformerBase<String, String> {
  Map<String, dynamic> values;

  SetSQLValues(this.values);

  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.transform(_setSqlValuesTransformer());
  }

  StreamTransformer<String, String> _setSqlValuesTransformer() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (data, sink) {
        values.keys.forEach((key) {
          if (data.contains(':$key')) {
            final value = values[key];
            if (value is String) {
              data = data.replaceAll(':$key', "'$value'");
            } else {
              data = data.replaceAll(':$key', '$value');
            }
          }
        });
        sink.add(data);
      },
    );
  }
}
