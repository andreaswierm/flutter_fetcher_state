import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

class TestScene<T> extends StatelessWidget {
  final Future<T> Function(BuildContext)? fetcher;
  final Stream<T> Function(BuildContext)? createStream;

  const TestScene({
    Key? key,
    this.fetcher,
    this.createStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Query.builder<T>(
        fetcher: fetcher,
        createStream: createStream,
        builder: (context, controller) {
          if (controller.isLoading) {
            return const Text("Loading");
          }

          if (controller.isFetching) {
            return const Text("Fetching");
          }

          if (controller.hasError) {
            return Text("Error: ${controller.error.toString()}");
          }

          if (controller.isEmpty) {
            return const Text("Empty");
          }

          if (controller.hasData) {
            return Column(
              children: [
                Text(controller.data.toString()),
                TextButton(
                  onPressed: () => controller.refetch(),
                  child: const Text("Refetch"),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
