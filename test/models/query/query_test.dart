import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'test_scene.dart';

void main() {
  group("Query", () {
    group("#builder()", () {
      testWidgets(
        "Should render all fetcher states to successful",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            TestScene(
              fetcher: (_) => Future.value("Hello world"),
            ),
          );

          expect(find.text("Loading"), findsOneWidget);

          await tester.pump();

          expect(find.text("Hello world"), findsOneWidget);
        },
      );

      testWidgets(
        "Should update the view with data from stream",
        (WidgetTester tester) async {
          final StreamController<String> _streamController = StreamController();

          await tester.pumpWidget(
            TestScene(
              createStream: (_) => _streamController.stream,
            ),
          );

          expect(find.text("Empty"), findsOneWidget);

          _streamController.add("Hello world");

          await tester.pump();

          expect(find.text("Hello world"), findsOneWidget);
        },
      );

      testWidgets(
        "Should show error when the API fails to fetch",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            TestScene(
              fetcher: (_) => Future.error("Failed to fetch"),
            ),
          );

          expect(find.text("Loading"), findsOneWidget);

          await tester.pump();

          expect(find.text("Error: Failed to fetch"), findsOneWidget);
        },
      );

      testWidgets(
        "Should allow to refetch",
        (WidgetTester tester) async {
          String data = "Hello world";

          await tester.pumpWidget(
            TestScene(
              fetcher: (_) => Future.value(data),
            ),
          );

          expect(find.text("Loading"), findsOneWidget);

          await tester.pump();

          expect(find.text("Hello world"), findsOneWidget);

          data = "Hello mercury";

          await tester.tap(find.text("Refetch"));

          await tester.pump();

          expect(find.text("Hello mercury"), findsOneWidget);
        },
      );
    });
  });
}
