import 'package:flutter/widgets.dart';
import 'package:skeletons/skeleton_bar.dart';

class StandardTextSkeleton extends StatelessWidget {
  final Widget? text;
  final double? skeletonWidth;

  const StandardTextSkeleton({
    Key? key,
    this.text,
    this.skeletonWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text != null) {
      return text!;
    } else {
      return BarSkeleton(width: skeletonWidth);
    }
  }
}
