import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

class TestMutationScene<T> extends StatelessWidget {
  final Future<T> Function(BuildContext) mutation;

  const TestMutationScene({
    Key? key,
    required this.mutation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Mutation.builder<T>(
        builder: (context, controller) {
          if (controller.isLoading) {
            return const Text("Loading");
          }

          if (controller.hasError) {
            return Text("Error: ${controller.error.toString()}");
          }

          return Column(
            children: [
              Text(controller.data.toString()),
              TextButton(
                onPressed: () => controller.mutate(mutation),
                child: const Text("Mutate"),
              ),
            ],
          );
        },
      ),
    );
  }
}
