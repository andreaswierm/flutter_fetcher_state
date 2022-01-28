import 'package:example/coins_repo/coins_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

class AddCoinDialog extends StatefulWidget {
  final void Function(Coin) onCreate;

  const AddCoinDialog({
    Key? key,
    required this.onCreate,
  }) : super(key: key);

  @override
  _AddCoinDialogState createState() => _AddCoinDialogState();

  static Future<Coin?> open(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AddCoinDialog(
          onCreate: Navigator.of(context).pop,
        );
      },
    );
  }
}

class _AddCoinDialogState extends State<AddCoinDialog> {
  String _name = "";
  final Mutation<Coin> _createCoinMutation = Mutation();

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder<Coin>(
      states: [_createCoinMutation],
      builder: (context) {
        return Form(
          child: Builder(
            builder: (context) {
              return AlertDialog(
                title: const Text("Register coin"),
                content: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Name",
                  ),
                  onSaved: (name) => _name = name ?? "",
                  validator: (name) {
                    if (name == null || name.isEmpty) return "Name is required";
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    child: _createCoinMutation.isFetching
                        ? const Text("Saving...")
                        : const Text("Save"),
                    onPressed: _createCoinMutation.isFetching
                        ? null
                        : () async {
                            final formState = Form.of(context);

                            if (formState == null) return;

                            formState.save();

                            if (formState.validate() == false) return;

                            widget.onCreate(
                              await _createCoinMutation.mutate(
                                CoinsRepo.of(context).add(
                                  Coin(name: _name),
                                ),
                              ),
                            );
                          },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
