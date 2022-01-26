import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../crypto_repo/crypto_repo.dart';
import '../../crypto_repo/mutations/add_coin/add_coin.dart';
import '../../crypto_repo/mutations/failure_mutation/failure_mutation.dart';
import '../../crypto_repo/queries/list_coins/list_coins.dart';
import '../../utils/build_mutation_state/build_mutation_state.dart';
import '../../utils/list_coins/list_coins.dart';

void main() {
  Widget renderApp({
    required CryptoRepo repo,
    required Mutation<Coin> mutation,
  }) {
    return MaterialApp(
      home: Mutation.builder<Coin>(builder: (context, mutationController) {
        return Query.builder<List<Coin>>(
          query: ListCoinsQuery(repo: repo),
          builder: (context, controller) {
            return BuildMutationState<Coin>(
              controller: mutationController,
              builder: (context) => Column(
                children: [
                  ListCoins(coins: controller.data ?? []),
                  TextButton(
                    child: const Text("add coin"),
                    onPressed: () => mutationController.mutate(mutation),
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }

  group("Mutation", () {
    group("#builder()", () {
      testWidgets(
        "Should start settled and call the api when the use taps on the button",
        (WidgetTester tester) async {
          final CryptoRepo repo = CryptoRepo(
            coins: [
              ethereumCoin,
              bitcoinCoin,
            ],
          );

          await tester.pumpWidget(
            renderApp(
              repo: repo,
              mutation: AddCoinMutation(
                coin: tetherCoin,
                repo: repo,
              ),
            ),
          );

          await tester.pump();

          expect(find.text(tetherCoin.name), findsNothing);

          await tester.tap(find.text("add coin"));

          await tester.pump();

          expect(find.text(tetherCoin.name), findsOneWidget);
        },
      );

      testWidgets(
        "Should get to error state when api return a error",
        (WidgetTester tester) async {
          final Exception exception = Exception("Failed to add coin");

          final CryptoRepo repo = CryptoRepo(
            coins: [
              ethereumCoin,
              bitcoinCoin,
            ],
          );

          await tester.pumpWidget(
            renderApp(
              repo: repo,
              mutation: FailureMutation(
                exception: exception,
              ),
            ),
          );

          await tester.pump();

          await tester.tap(find.text("add coin"));

          await tester.pump();

          expect(find.text(exception.toString()), findsOneWidget);
        },
      );
    });
  });
}
