import 'package:flutter/material.dart';

import 'shimmer.dart';

class BarSkeleton extends StatelessWidget {
  // enter a width of null to expand to maximum
  final double? width;
  final double? height;

  const BarSkeleton({Key? key, this.width, this.height = 16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
