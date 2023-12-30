import 'package:flutter/material.dart';

class SlideUpTransition extends StatelessWidget {
  final Widget child;
  final Animation animation;
  final Offset offset;

  const SlideUpTransition({
    super.key,
    required this.child,
    required this.animation,
    this.offset = const Offset(0, 0.20),
  });

  @override
  Widget build(BuildContext context) {
    var tween = Tween(
      begin: offset,
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeOutQuad));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
