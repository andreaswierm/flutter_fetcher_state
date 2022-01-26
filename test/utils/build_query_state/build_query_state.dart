import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

class BuildQueryState<T> extends StatelessWidget {
  final QueryController<T> controller;
  final Widget Function(BuildContext context, T data) builder;

  const BuildQueryState({
    Key? key,
    required this.builder,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Text("Loading");
    }

    if (controller.isFetching) {
      return const Text("Fetching");
    }

    if (controller.hasError) {
      return Text(controller.error.toString());
    }

    if (controller.isEmpty) {
      return const Text("Empty");
    }

    if (controller.hasData) {
      return builder(context, controller.data!);
    }

    return const SizedBox();
  }
}
