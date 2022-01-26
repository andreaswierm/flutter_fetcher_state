import 'package:flutter/material.dart';

abstract class BaseMutation<T> {
  Future<T> mutate(BuildContext context);
}
