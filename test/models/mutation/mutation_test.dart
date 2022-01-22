import 'package:flutter_test/flutter_test.dart';

import 'test_mutation_scene.dart';

void main() {
  group("Mutation", () {
    group("#builder()", () {
      testWidgets(
        "Should start settled and call the api when the use taps on the button",
        (WidgetTester tester) async {
          final testMatcher = find.text("I came from API");
          await tester.pumpWidget(
            TestMutationScene(
              mutation: (_) => Future.delayed(
                  const Duration(
                    milliseconds: 1,
                  ),
                  () => "I came from API"),
            ),
          );

          await tester.pump();

          expect(testMatcher, findsNothing);

          await tester.tap(find.text("Mutate"));

          await tester.pump();

          expect(find.text("Loading"), findsOneWidget);

          await tester.pump(
            const Duration(
              milliseconds: 1,
            ),
          );

          expect(testMatcher, findsOneWidget);
        },
      );

      testWidgets(
        "Should get to error state when api return a error",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            TestMutationScene(
              mutation: (_) => Future.error("500"),
            ),
          );

          await tester.pump();

          await tester.tap(find.text("Mutate"));

          await tester.pump();

          expect(find.text("Error: 500"), findsOneWidget);
        },
      );
    });
  });
}
