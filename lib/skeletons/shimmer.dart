import 'package:flutter/widgets.dart';

class _SlideGradientTransform extends GradientTransform {
  const _SlideGradientTransform({
    required this.percent,
  });

  final double percent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * percent, 0.0, 0.0);
  }
}

class Shimmer extends StatefulWidget {
  final Widget child;

  const Shimmer({Key? key, required this.child}) : super(key: key);

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> {
  @override
  Widget build(BuildContext context) {
    final shimmer = ShimmerProvider.of(context);

    if (shimmer == null) {
      throw 'ShimmerProvider is missing.';
    }

    if (!shimmer.isSized) {
      // Ancestor Shimmer isn’t laid out yet, return empty box
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final renderObject = context.findRenderObject();
    Offset? offsetWithinShimmer;
    if (renderObject != null && renderObject is RenderBox) {
      offsetWithinShimmer = shimmer.getDescendantOffset(
        descendant: renderObject,
      );
    }

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -(offsetWithinShimmer?.dx ?? 0),
            -(offsetWithinShimmer?.dy ?? 0),
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }

  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = ShimmerProvider.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    setState(() {/* update the shimmer painting */});
  }
}

class ShimmerProvider extends StatefulWidget {
  static const _defaultShimmerGradient = LinearGradient(
    colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  final LinearGradient linearGradient;
  final Widget child;

  const ShimmerProvider({
    Key? key,
    required this.child,
    this.linearGradient = _defaultShimmerGradient,
  }) : super(key: key);
  static ShimmerProviderState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerProviderState>();
  }

  @override
  ShimmerProviderState createState() => ShimmerProviderState();
}

class ShimmerProviderState extends State<ShimmerProvider>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Listenable get shimmerChanges => _animationController;

  LinearGradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform: _SlideGradientTransform(
          percent: _animationController.value,
        ),
      );

  bool get isSized =>
      context.findRenderObject() != null &&
      (context.findRenderObject() as RenderBox).hasSize;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }
}
