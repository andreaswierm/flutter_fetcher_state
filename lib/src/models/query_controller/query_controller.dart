import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/src/models/query/query.dart';
import 'package:flutter_fetcher_state/src/models/query_status_notifier/query_status_notifier.dart';

class QueryController<T> extends QueryStatusNotifier<T> {
  final Query<T> query;
  StreamSubscription<T>? _streamSubscription;
  final BuildContext Function() getBuildContext;

  QueryController({
    required this.query,
    required this.getBuildContext,
  });

  BuildContext get context => getBuildContext();

  void start() {
    _startFetcher();

    _streamSubscription = query.subscribe(context)?.listen(setData);
  }

  void _startFetcher() async {
    final future = query.fetch(context);

    if (future == null) return;

    setIsLoading();

    await _handleFuture(future);
  }

  @override
  void dispose() async {
    super.dispose();

    await _streamSubscription?.cancel();
  }

  Future<void> fetch() async {
    final future = query.fetch(context);

    setFetching();

    return _handleFuture(future);
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
