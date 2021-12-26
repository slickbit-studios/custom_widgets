import 'package:flutter/widgets.dart';

abstract class Filter<T> {
  String get name;
  bool allows(T object);
}

class FilterFactory<T> {
  final String Function(BuildContext context) titleBuilder;
  final Future<Filter<T>?> Function(BuildContext context)? filterBuilder;
  final dynamic type;

  FilterFactory({
    required this.titleBuilder,
    this.filterBuilder,
    required this.type,
  });
}
