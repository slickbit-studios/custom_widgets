import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'shimmer.dart';

class SkeletonList<T> extends StatefulWidget {
  final Stream<List<T>> Function() streamBuilder;
  final int skeletonCount;
  final Widget Function(T object) cardBuilder;
  final Widget Function() skeletonBuilder;
  final Widget? errorView;
  final Widget? emptyView;

  const SkeletonList({
    Key? key,
    required this.streamBuilder,
    required this.cardBuilder,
    required this.skeletonBuilder,
    this.skeletonCount = 3,
    this.errorView,
    this.emptyView,
  }) : super(key: key);

  @override
  _SkeletonListState createState() => _SkeletonListState<T>();
}

class _SkeletonListState<T> extends State<SkeletonList<T>> {
  late Stream<List<T>> _stream;

  @override
  void initState() {
    super.initState();

    _stream = widget.streamBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: _stream,
      builder: (context, snapshot) {
        Widget child;

        if (snapshot.hasData) {
          List<T> objects = snapshot.data!;
          if (objects.isNotEmpty) {
            child = ListView.builder(
              itemBuilder: (context, index) =>
                  widget.cardBuilder(objects[index]),
              itemCount: objects.length,
            );
          } else {
            // wrap in scrollview to enable refresh indicator
            // TODO: refresh not working
            child = SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: widget.emptyView ?? const SizedBox(),
            );
          }
        } else if (snapshot.hasError) {
          // wrap in scrollview to enable refresh indicator
          // TODO: refresh not working
          child = SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: widget.errorView ?? const SizedBox(),
          );
        } else {
          child = ShimmerProvider(
            child: ListView.builder(
              itemBuilder: (context, index) => widget.skeletonBuilder(),
              itemCount: widget.skeletonCount,
            ),
          );
        }

        return RefreshIndicator(onRefresh: _rebuildStream, child: child);
      },
    );
  }

  Future<void> _rebuildStream() async {
    setState(() {
      _stream = widget.streamBuilder();
    });
    await Future.delayed(const Duration(seconds: 1));
  }
}
