enum AsyncStatus {
  fetching,
  loading,
  success,
  error,
  empty,
}

class AsyncState<T extends dynamic> {
  final T? data;
  final Object? error;
  final AsyncStatus status;

  AsyncState({
    this.data,
    this.error,
    required this.status,
  });

  static AsyncState<T> success<T>(T data) => AsyncState(
        status: AsyncStatus.success,
        data: data,
      );

  static AsyncState<T> loading<T>() => AsyncState(
        status: AsyncStatus.loading,
      );

  static AsyncState<T> failure<T>(Object error) => AsyncState(
        status: AsyncStatus.error,
        error: error,
      );

  static AsyncState<T> empty<T>() => AsyncState(
        status: AsyncStatus.empty,
      );

  static AsyncState<T> fetching<T>(T? data) => AsyncState(
        status: AsyncStatus.fetching,
        data: data,
      );
}
