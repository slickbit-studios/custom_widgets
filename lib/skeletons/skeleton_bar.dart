import 'package:flutter/material.dart';

import 'shimmer.dart';

class BarSkeleton extends StatelessWidget {
  // enter a width of null to expand to maximum
  final double? width;
  final double? height;
  final Color background;

  const BarSkeleton({
    Key? key,
    this.width,
    this.height = 16,
    this.background = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
