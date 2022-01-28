import 'package:flutter/widgets.dart';
import 'package:flutter_fetcher_state/src/models/query/query.dart';
import 'package:flutter_fetcher_state/src/widgets/async_state_builder/async_state_builder.dart';

class QueryBuilder<T> extends StatefulWidget {
  final Query<T> Function(BuildContext) create;
  final Widget Function(BuildContext, Query<T> query) builder;

  const QueryBuilder({
    Key? key,
    required this.create,
    required this.builder,
  }) : super(key: key);

  @override
  _QueryBuilderState createState() => _QueryBuilderState<T>();
}

class _QueryBuilderState<T> extends State<QueryBuilder<T>> {
  late final Query<T> query = widget.create(context);

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      states: [query],
      builder: (context) => widget.builder(context, query),
    );
  }
}
