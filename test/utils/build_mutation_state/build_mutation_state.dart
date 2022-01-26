import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

class BuildMutationState<T> extends StatelessWidget {
  final MutationController<T> controller;
  final Widget Function(BuildContext context) builder;

  const BuildMutationState({
    Key? key,
    required this.builder,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Text("Loading");
    }

    if (controller.hasError) {
      return Text(controller.error.toString());
    }

    return builder(context);
  }
}
