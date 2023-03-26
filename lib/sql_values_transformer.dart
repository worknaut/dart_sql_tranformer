import 'dart:async';

class SqlValuesTransformer extends StreamTransformerBase<String, String> {
  Map<String, dynamic> values;

  SqlValuesTransformer(this.values);

  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.transform(_setSqlValuesTransformer());
  }

  StreamTransformer<String, String> _setSqlValuesTransformer() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (data, sink) {
        for (var key in values.keys) {
          if (data.contains(':$key')) {
            final value = values[key];
            if (value is String) {
              data = data.replaceAll(':$key', "'$value'");
            } else {
              data = data.replaceAll(':$key', '$value');
            }
          }
        }
        sink.add(data);
      },
    );
  }
}
