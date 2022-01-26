import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../crypto_repo/crypto_repo.dart';
import '../../crypto_repo/mutations/add_coin/add_coin.dart';
import '../../crypto_repo/mutations/failure_mutation/failure_mutation.dart';

void main() {
  group("MutationNotifier", () {
    testWidgets(
      "Should run the onSuccess callback",
      (WidgetTester tester) async {
        Coin? coin;

        final CryptoRepo repo = CryptoRepo(
          coins: [
            ethereumCoin,
            bitcoinCoin,
          ],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Mutation.builder<Coin>(
              notifier: MutationNotifier(
                onSuccess: (_coin) => coin = _coin,
              ),
              builder: (context, controller) => TextButton(
                child: const Text("Click me"),
                onPressed: () => controller.mutate(
                  AddCoinMutation(
                    coin: tetherCoin,
                    repo: repo,
                  ),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text("Click me"));

        expect(coin, tetherCoin);
      },
    );

    testWidgets(
      "Should run the onError callback",
      (WidgetTester tester) async {
        Object? error;
        final Exception exception = Exception("Failed to add coin");

        await tester.pumpWidget(
          MaterialApp(
            home: Mutation.builder<Coin>(
              notifier: MutationNotifier(
                onError: (_error) => error = _error,
              ),
              builder: (context, controller) => TextButton(
                child: const Text("Click me"),
                onPressed: () => controller.mutate(
                  FailureMutation(
                    exception: exception,
                  ),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text("Click me"));

        expect(error, exception);
      },
    );
  });
}
