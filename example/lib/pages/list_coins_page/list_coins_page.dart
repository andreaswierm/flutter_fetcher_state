import 'package:example/coins_repo/coins_repo.dart';
import 'package:example/common/add_coin_dialog/add_coin_dialog.dart';
import 'package:example/common/search_coins_delegate/search_coins_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

class ListCoinsPage extends StatefulWidget {
  const ListCoinsPage({Key? key}) : super(key: key);

  @override
  State<ListCoinsPage> createState() => _ListCoinsPageState();

  static String get route => "/coins";
}

class _ListCoinsPageState extends State<ListCoinsPage> {
  late final Query<List<Coin>> searchCoinsQuery = Query(
    streamBuilder: Query.compose([
      Stream.fromFuture(CoinsRepo.of(context).fetchAll()),
      CoinsRepo.of(context).stream,
    ]),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coins"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await showSearch<Coin?>(
                context: context,
                delegate: SearchCoinsDelegate(),
              );
            },
          ),
        ],
      ),
      body: AsyncStateBuilder(
        states: [searchCoinsQuery],
        builder: (context) {
          final results = searchCoinsQuery.data ?? [];

          if (searchCoinsQuery.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () => Query.refetch(searchCoinsQuery),
            child: ListView(
              children: results
                  .map(
                    (coin) => ListTile(
                      title: Text(coin.name),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddCoinDialog.open(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
