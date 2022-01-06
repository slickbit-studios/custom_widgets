import 'package:flutter/widgets.dart';

abstract class Validator<T> {
  String? validate(BuildContext context, T? value);
}
