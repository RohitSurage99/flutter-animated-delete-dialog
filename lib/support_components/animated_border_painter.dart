import 'dart:ui';
import 'package:flutter/material.dart';
class AnimatedBorderPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final double strokeWidth;
  final double borderRadius;
  final bool reverse;
  final Path? customPath;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  List<PathMetric>? _cachedMetrics;
  Path? _cachedPath;
  Size? _cachedSize;

  AnimatedBorderPainter({
    required this.animation,
    this.color = Colors.blue,
    this.strokeWidth = 1.0,
    this.borderRadius = 8.0,
    this.reverse = false,
    this.customPath,
    this.strokeCap = StrokeCap.butt,
    this.strokeJoin = StrokeJoin.miter,
  })  : assert(strokeWidth > 0, 'strokeWidth must be positive'),
        assert(borderRadius >= 0, 'borderRadius cannot be negative'),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..strokeJoin = strokeJoin;
    final path = _getPath(size);
    if (_cachedSize != size || _cachedMetrics == null) {
      _cachedMetrics = path.computeMetrics().toList(growable: false);
      _cachedSize = size;
      _cachedPath = path;
    }

    final totalLength = _cachedMetrics!.fold(0.0, (sum, metric) => sum + metric.length);
    final progress = animation.value.clamp(0.0, 1.0);
    final currentLength = reverse ? totalLength * (1 - progress) : totalLength * progress;
    final animatedPath = _extractPath(_cachedMetrics!, currentLength);
    canvas.drawPath(animatedPath, paint);
  }

  Path _getPath(Size size) {
    if (customPath != null) {
      return customPath!;
    } else {
      final rect = Rect.fromLTWH(0, 0, size.width, size.height);
      return Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)));
    }
  }

  Path _extractPath(List<PathMetric> metrics, double length) {
    final path = Path();
    double remainingLength = length;

    for (final metric in metrics) {
      if (remainingLength <= 0) break;

      final extractLength = remainingLength.clamp(0.0, metric.length);
      path.addPath(metric.extractPath(0, extractLength), Offset.zero);
      remainingLength -= extractLength;
    }

    return path;
  }

  @override
  bool shouldRepaint(covariant AnimatedBorderPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.reverse != reverse ||
        oldDelegate.customPath != customPath ||
        oldDelegate.strokeCap != strokeCap ||
        oldDelegate.strokeJoin != strokeJoin;
  }
}