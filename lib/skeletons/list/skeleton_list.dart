import 'package:flutter/material.dart';

import '../shimmer.dart';
import 'controller.dart';

export 'controller.dart';
export 'filter.dart';
export 'sort.dart';

class SkeletonList<T> extends StatefulWidget {
  final ListStreamController<T> controller;
  final int skeletonCount;
  final Widget Function(T object) cardBuilder;
  final Widget Function() skeletonBuilder;
  final Widget errorView;
  final Widget emptyView;

  const SkeletonList({
    super.key,
    required this.controller,
    required this.cardBuilder,
    required this.skeletonBuilder,
    this.skeletonCount = 3,
    this.errorView = const SizedBox(),
    this.emptyView = const SizedBox(),
  });

  @override
  SkeletonListState createState() => SkeletonListState<T>();
}

class SkeletonListState<T> extends State<SkeletonList<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: widget.controller.stream,
      builder: (context, snapshot) {
        Widget child;

        if (snapshot.hasData) {
          List<T> objects = snapshot.data!;
          if (objects.isNotEmpty) {
            child = ShimmerProvider(
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    widget.cardBuilder(objects[index]),
                itemCount: objects.length,
              ),
            );
          } else {
            // wrap in scrollview to enable refresh indicator
            child = Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: widget.emptyView,
                  ),
                )
              ],
            );
          }
        } else if (snapshot.hasError) {
          // wrap in scrollview to enable refresh indicator
          child = Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: widget.errorView,
                ),
              ),
            ],
          );
        } else {
          child = ShimmerProvider(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => widget.skeletonBuilder(),
              itemCount: widget.skeletonCount,
            ),
          );
        }

        return RefreshIndicator(onRefresh: _reload, child: child);
      },
    );
  }

  Future<void> _reload() async {
    await widget.controller.reload();
    await Future.delayed(const Duration(seconds: 1)); // for better animation
  }
}
