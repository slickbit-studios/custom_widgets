import 'package:flutter/widgets.dart';

class NullableWrap extends StatelessWidget {
  final dynamic value;
  final Widget Function() nonNull;
  final Widget Function() isNull;

  const NullableWrap({
    Key? key,
    required this.value,
    required this.nonNull,
    required this.isNull,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return isNull();
    }
    return nonNull();
  }
}
