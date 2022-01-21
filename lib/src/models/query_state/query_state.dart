class QueryState<T> {
  final T? data;
  final bool isLoading;
  final bool isFetching;
  final Object? error;

  QueryState({
    this.data,
    this.error,
    this.isFetching = false,
    this.isLoading = false,
  });

  bool get isEmpty => data == null;
  bool get hasError => error != null;
  bool get hasData => data != null;

  static QueryState<T> empty<T>() => QueryState();

  static QueryState<T> successful<T>(T data) {
    return QueryState(
      data: data,
    );
  }

  static QueryState<T> failure<T>(Object error) {
    return QueryState(
      error: error,
    );
  }

  static QueryState<T> loading<T>() {
    return QueryState(
      isLoading: true,
      isFetching: true,
    );
  }

  static QueryState<T> fetching<T>(T? data) {
    return QueryState(
      data: data,
      isFetching: true,
    );
  }
}
