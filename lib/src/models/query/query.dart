import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';
import 'package:flutter_fetcher_state/src/common_actions/set_async_state_action/set_async_state_action.dart';
import 'package:flutter_fetcher_state/src/models/base_query/base_query.dart';
import 'package:async/async.dart';

class Query<T> extends BaseQuery<T> {
  Query({
    required Stream<T> Function() streamBuilder,
  }) : super(streamBuilder: streamBuilder) {
    executeActions([
      SetAsyncStateAction(
        state: AsyncState.loading(),
      ),
      SubscribeAction(),
    ]);
  }

  T? get data => state.data;
  Object? get error => state.error;
  bool get isLoading => state.status == AsyncStatus.loading;
  bool get isFetching => state.status == AsyncStatus.fetching || isLoading;
  bool get hasData => state.data != null;
  bool get hasError => state.error != null;

  static Query<T> fetcher<T>(
    Future<T> Function() fetcher,
  ) =>
      Query(
        streamBuilder: () => Stream.fromFuture(
          fetcher(),
        ),
      );

  static Future<void> refetch<T>(Query<T> query) async {
    return query.executeActions([
      SetAsyncStateAction(
        state: AsyncState.fetching(query.data),
      ),
      UnsubscribeAction(),
      SubscribeAction(),
    ]);
  }

  static Stream<T> Function() compose<T>(Iterable<Stream<T>> streams) {
    return () => StreamGroup.merge(streams);
  }
}
