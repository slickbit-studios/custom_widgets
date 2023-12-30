import 'package:flutter/widgets.dart';

class PreventPop extends StatelessWidget {
  final Widget child;

  const PreventPop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: child, onWillPop: () async => false);
  }
}
