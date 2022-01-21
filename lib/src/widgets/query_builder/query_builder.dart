import 'package:flutter/widgets.dart';
import 'package:flutter_fetcher_state/src/models/query_controller/query_controller.dart';
import 'package:flutter_fetcher_state/src/types.dart';
import 'package:provider/provider.dart';

class QueryBuilder<T> extends StatelessWidget {
  final QueryController<T> Function(BuildContext) create;
  final AsyncQueryBuilder<T> builder;

  const QueryBuilder({
    Key? key,
    required this.builder,
    required this.create,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: create,
      child: Consumer<QueryController<T>>(
        builder: (context, model, _) => builder(context, model),
      ),
    );
  }
}
