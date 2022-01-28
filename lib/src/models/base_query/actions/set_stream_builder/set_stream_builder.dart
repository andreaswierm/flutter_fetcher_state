import 'package:flutter_fetcher_state/src/models/async_state_action/async_state_action.dart';
import 'package:flutter_fetcher_state/src/models/base_query/base_query.dart';

class SetStreamBuilderAction<T> implements AsyncStateAction<T> {
  final Stream<T> Function() streamBuilder;

  SetStreamBuilderAction({
    required this.streamBuilder,
  });

  @override
  Future<void> execute(BaseQuery<T> controller) async {
    controller.streamBuilder = streamBuilder;
  }
}
