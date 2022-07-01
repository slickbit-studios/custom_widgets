import 'package:flutter/material.dart';

import 'shimmer.dart';

class BarSkeleton extends StatelessWidget {
  // enter a width of null to expand to maximum
  final double? width;
  final double height;
  final Color background;
  final BorderRadiusGeometry? borderRadius;

  const BarSkeleton({
    Key? key,
    this.width,
    this.height = 16,
    this.background = Colors.white,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: background,
          borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
        ),
      ),
    );
  }
}
