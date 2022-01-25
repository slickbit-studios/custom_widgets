import 'package:flutter/cupertino.dart';

class PreventPop extends StatelessWidget {
  final Widget child;

  const PreventPop({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: child, onWillPop: () async => false);
  }
}
