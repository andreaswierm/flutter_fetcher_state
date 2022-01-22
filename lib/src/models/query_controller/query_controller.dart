import 'dart:async';

import 'package:flutter_fetcher_state/src/models/query_status_notifier/query_status_notifier.dart';

class QueryController<T> extends QueryStatusNotifier<T> {
  final Future<T>? Function()? fetcher;
  final Stream<T>? Function()? createStream;

  QueryController({
    this.fetcher,
    this.createStream,
  }) {
    load();
    subscribe();
  }

  Future<void> load() async {
    final future = fetcher?.call();

    if (future == null) return;

    setIsLoading();

    return _handleFuture(future);
  }

  Future<void> refetch() async {
    final future = fetcher?.call();

    if (future == null) return;

    setFetching();

    return _handleFuture(future);
  }

  void subscribe() {
    final Stream<T>? stream = createStream?.call();

    if (stream == null) return;

    stream.listen(setData);
  }

  void debug() {
    final text = """
    ---
    hasData: $hasData
    hasError: $hasError
    isEmpty: $isEmpty
    isFetching: $isFetching
    isLoading: $isLoading
    data: $data
    error: $error
    """;

    // ignore: avoid_print
    print(text);
  }

  Future<void> _handleFuture(Future<T>? future) async {
    try {
      if (future == null) return;

      final T data = await future;

      setData(data);
    } catch (err) {
      setError(err);
    }
  }
}
