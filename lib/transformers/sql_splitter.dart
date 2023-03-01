import 'dart:async';

class SQLSplitter extends StreamTransformerBase<String, String> {
  const SQLSplitter();

  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.transform(_sqlSplitterTransformer());
  }

  StreamTransformer<String, String> _sqlSplitterTransformer() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (data, sink) {
        data = data.trim();
        if (data.isEmpty) return;
        if (data.contains(';')) {
          final split = data.split(';');
          for (var i = 0; i < split.length; i++) {
            final element = split[i];
            if (element.isEmpty) continue;
            sink.add('${element.trim()};');
          }
        }
      },
    );
  }
}
