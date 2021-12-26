import 'package:flutter/widgets.dart';

abstract class Sort<T> {
  bool ascending;

  Sort({this.ascending = true});

  int compareTo(T first, T second);

  bool equals(T first, T second) => compareTo(first, second) == 0;
  bool isSmaller(T first, T second) =>
      (compareTo(first, second) < 0 && ascending) ||
      (compareTo(first, second) > 0 && !ascending);
  bool isGreater(T first, T second) =>
      (compareTo(first, second) > 0 && ascending) ||
      (compareTo(first, second) < 0 && !ascending);

  void invert() => ascending = !ascending;
}

class SortFactory<T> {
  final String Function(BuildContext context) titleBuilder;
  final Future<Sort<T>?> Function(BuildContext context)? sortBuilder;
  final dynamic type;

  SortFactory({
    required this.titleBuilder,
    this.sortBuilder,
    required this.type,
  });
}
