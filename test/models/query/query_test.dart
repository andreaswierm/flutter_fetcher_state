import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../crypto_repo/crypto_repo.dart';
import '../../crypto_repo/queries/failure_query/failure_query.dart';
import '../../crypto_repo/queries/list_coins/list_coins.dart';
import '../../crypto_repo/queries/list_coins_stream_only/list_coins_stream_only.dart';
import '../../utils/build_query_state/build_query_state.dart';
import '../../utils/list_coins/list_coins.dart';

void main() {
  Widget renderApp({
    required Query<List<Coin>> query,
  }) {
    return MaterialApp(
      home: Query.builder<List<Coin>>(
        query: query,
        builder: (context, controller) {
          return BuildQueryState<List<Coin>>(
            controller: controller,
            builder: (context, coins) => Column(
              children: [
                ListCoins(coins: coins),
                TextButton(
                  child: const Text("reload"),
                  onPressed: () => controller.fetch(),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  group("Query", () {
    group("#builder()", () {
      testWidgets(
        "Should list all coins",
        (WidgetTester tester) async {
          final CryptoRepo repo = CryptoRepo(
            coins: [
              ethereumCoin,
              bitcoinCoin,
            ],
          );

          await tester.pumpWidget(
            renderApp(
              query: ListCoinsQuery(repo: repo),
            ),
          );

          expect(find.text("Loading"), findsOneWidget);

          await tester.pump();

          expect(find.text(ethereumCoin.name), findsOneWidget);
          expect(find.text(bitcoinCoin.name), findsOneWidget);
        },
      );

      testWidgets(
        "Should update the view with data from stream",
        (WidgetTester tester) async {
          final CryptoRepo repo = CryptoRepo(
            coins: [
              ethereumCoin,
              bitcoinCoin,
            ],
          );

          await tester.pumpWidget(
            renderApp(
              query: ListCoinsStreamOnlyQuery(repo: repo),
            ),
          );

          expect(find.text("Empty"), findsOneWidget);

          await repo.add(tetherCoin);

          await tester.pump();

          expect(find.text(ethereumCoin.name), findsOneWidget);
          expect(find.text(bitcoinCoin.name), findsOneWidget);
          expect(find.text(tetherCoin.name), findsOneWidget);
        },
      );

      testWidgets(
        "Should show error when the API fails to fetch",
        (WidgetTester tester) async {
          final Exception exception = Exception("Failed to fetch");

          await tester.pumpWidget(
            renderApp(
              query: FailureQuery(exception: exception),
            ),
          );

          expect(find.text("Loading"), findsOneWidget);

          await tester.pump();

          expect(find.text(exception.toString()), findsOneWidget);
        },
      );

      testWidgets(
        "Should allow to refetch",
        (WidgetTester tester) async {
          final CryptoRepo repo = CryptoRepo(
            coins: [
              ethereumCoin,
              bitcoinCoin,
            ],
          );

          await tester.pumpWidget(
            renderApp(
              query: ListCoinsQuery(repo: repo),
            ),
          );

          expect(find.text("Loading"), findsOneWidget);

          await tester.pump();

          expect(find.text(ethereumCoin.name), findsOneWidget);
          expect(find.text(bitcoinCoin.name), findsOneWidget);
          expect(find.text(tetherCoin.name), findsNothing);

          await repo.add(tetherCoin);

          await tester.tap(find.text("reload"));

          await tester.pump();

          expect(find.text(ethereumCoin.name), findsOneWidget);
          expect(find.text(bitcoinCoin.name), findsOneWidget);
          expect(find.text(tetherCoin.name), findsOneWidget);
        },
      );
    });
  });
}
