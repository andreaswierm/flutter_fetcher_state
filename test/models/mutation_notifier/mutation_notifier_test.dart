import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("MutationNotifier", () {
    testWidgets(
      "Should run the onSuccess callback",
      (WidgetTester tester) async {
        String? data;

        await tester.pumpWidget(
          MaterialApp(
            home: Mutation.builder<String>(
              notifier: MutationNotifier(
                onSuccess: (_data) => data = _data,
              ),
              builder: (context, controller) => TextButton(
                child: const Text("Click me"),
                onPressed: () => controller.mutate(
                  (context) => Future.value("Hello"),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text("Click me"));

        expect(data, "Hello");
      },
    );

    testWidgets(
      "Should run the onError callback",
      (WidgetTester tester) async {
        Object? error;

        await tester.pumpWidget(
          MaterialApp(
            home: Mutation.builder<String>(
              notifier: MutationNotifier(
                onError: (_error) => error = _error,
              ),
              builder: (context, controller) => TextButton(
                child: const Text("Click me"),
                onPressed: () => controller.mutate(
                  (context) => Future.error("500"),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text("Click me"));

        expect(error, "500");
      },
    );
  });
}
