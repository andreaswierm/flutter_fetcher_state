import 'package:flutter/widgets.dart';
import 'package:flutter_fetcher_state/src/models/mutation_controller/mutation_controller.dart';
import 'package:flutter_fetcher_state/src/types.dart';
import 'package:provider/provider.dart';

class MutationBuilder<T> extends StatelessWidget {
  final MutationController<T> Function(BuildContext) create;
  final AsyncMutationBuilder<T> builder;

  const MutationBuilder({
    Key? key,
    required this.builder,
    required this.create,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MutationController<T>>(
      create: create,
      child: Consumer<MutationController<T>>(
        builder: (context, controller, _) => builder(context, controller),
      ),
    );
  }
}
