import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'shimmer.dart';

class BarSkeleton extends StatelessWidget {
  // enter a width of null to expand to maximum
  final double? width;

  const BarSkeleton({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        width: width ?? double.infinity,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
