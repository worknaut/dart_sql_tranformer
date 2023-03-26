import 'dart:async';

class SqlCommentTransformer extends StreamTransformerBase<String, String> {
  const SqlCommentTransformer();

  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.transform(_sqlSplitterTransformer());
  }

  StreamTransformer<String, String> _sqlSplitterTransformer() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (data, sink) {
        data = data.trim();
        if (data.isEmpty) return;
        if (data.startsWith('--')) return;
        if (data.startsWith('/*')) return;
        if (data.startsWith('*/')) return;
      },
    );
  }
}
