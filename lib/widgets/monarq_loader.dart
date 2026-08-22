import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class MonarqLoader extends StatefulWidget {
  final String message;

  const MonarqLoader({
    Key? key,
    this.message = "Curating your style...",
  }) : super(key: key);

  @override
  State<MonarqLoader> createState() => _MonarqLoaderState();
}

class _MonarqLoaderState extends State<MonarqLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _localT(double t, double start, double end) {
    if (t <= start) return 0;
    if (t >= end) return 1;
    return (t - start) / (end - start);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gold = theme.colorScheme.secondary;
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value;

              final drawT = _localT(t, 0.0, 0.5);
              final handExtra = _localT(t, 0.5, 0.62);
              final shimmerT = _localT(t, 0.55, 0.80);
              final fadeOutT = _localT(t, 0.80, 0.90);
              final fadeInT = _localT(t, 0.90, 1.0);

              double opacity = 1.0;
              if (fadeOutT > 0 && fadeInT == 0) {
                opacity = 1.0 - (0.30 * fadeOutT);
              } else if (fadeInT > 0) {
                opacity = 0.70 + (0.30 * fadeInT);
              }

              return Opacity(
                opacity: opacity,
                child: ShaderMask(
                  blendMode: shimmerT > 0 && shimmerT < 1
                      ? BlendMode.srcATop
                      : BlendMode.dstIn,
                  shaderCallback: (rect) {
                    if (shimmerT <= 0 || shimmerT >= 1) {
                      // no shimmer — fully opaque passthrough
                      return const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ).createShader(rect);
                    }
                    final center = -0.4 + (1.8 * shimmerT);
                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        gold,
                        Colors.white,
                        gold,
                      ],
                      stops: [
                        (center - 0.18).clamp(0.0, 1.0),
                        center.clamp(0.0, 1.0),
                        (center + 0.18).clamp(0.0, 1.0),
                      ],
                    ).createShader(rect);
                  },
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: CustomPaint(
                      painter: _EmblemPainter(
                        drawProgress: drawT,
                        handRotation: handExtra,
                        color: gold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 28),
          Text(
            "MONARQ",
            style: TextStyle(
              color: primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 4.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.message,
            style: TextStyle(
              color: grayText,
              fontSize: 12,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws the MONARQ emblem (clock ring + hanger hook + clock hands)
/// progressively based on [drawProgress] (0 -> 1), with a small extra
/// hand rotation controlled by [handRotation] (0 -> 1) once drawing
/// completes.
class _EmblemPainter extends CustomPainter {
  final double drawProgress;
  final double handRotation;
  final Color color;

  _EmblemPainter({
    required this.drawProgress,
    required this.handRotation,
    required this.color,
  });

  Path _partialPath(Path source, double t) {
    if (t <= 0) return Path();
    if (t >= 1) return source;
    final metrics = source.computeMetrics().toList();
    final totalLength = metrics.fold<double>(0, (sum, m) => sum + m.length);
    final targetLength = totalLength * t;

    final result = Path();
    double consumed = 0;
    for (final metric in metrics) {
      if (consumed >= targetLength) break;
      final remaining = targetLength - consumed;
      final take = math.min(metric.length, remaining);
      result.addPath(metric.extractPath(0, take), Offset.zero);
      consumed += metric.length;
    }
    return result;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()..color = color;

    final cx = size.width / 2;
    final cy = size.height / 2 + 6;
    final r = size.width * 0.30;

    // --- Segment budgets within drawProgress (0..1) ---
    // Ring: 0.00 - 0.45
    // Hook: 0.45 - 0.65
    // Hand 1 (hour): 0.65 - 0.82
    // Hand 2 (minute): 0.82 - 1.00
    double seg(double start, double end) {
      if (drawProgress <= start) return 0;
      if (drawProgress >= end) return 1;
      return (drawProgress - start) / (end - start);
    }

    final ringT = seg(0.0, 0.45);
    final hookT = seg(0.45, 0.65);
    final hand1T = seg(0.65, 0.82);
    final hand2T = seg(0.82, 1.0);

    // Ring
    if (ringT > 0) {
      final ringPath = Path()
        ..addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));
      canvas.drawPath(_partialPath(ringPath, ringT), paint);
    }

    // Tick dots — fade in once ring is basically complete
    if (ringT > 0.85) {
      final dotOpacity = ((ringT - 0.85) / 0.15).clamp(0.0, 1.0);
      final dp = Paint()..color = color.withValues(alpha: dotOpacity);
      for (final angle in [0.0, 90.0, 180.0, 270.0]) {
        final rad = angle * math.pi / 180;
        final p = Offset(cx + r * math.sin(rad), cy - r * math.cos(rad));
        canvas.drawCircle(p, 2.2, dp);
      }
    }

    // Hook (arc + short vertical stem) above the ring
    if (hookT > 0) {
      final hookPath = Path();
      final hookCenter = Offset(cx, cy - r - 10);
      hookPath.addArc(
        Rect.fromCenter(center: hookCenter, width: 22, height: 18),
        math.pi,
        math.pi,
      );
      hookPath.moveTo(cx, cy - r - 10);
      hookPath.lineTo(cx, cy - r + 4);
      canvas.drawPath(_partialPath(hookPath, hookT), paint);
    }

    // Clock hands (drawn last, with subtle extra rotation once complete)
    final extraAngle = handRotation * (math.pi / 10); // small ~18° sweep

    if (hand1T > 0) {
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(extraAngle * 0.6);
      canvas.translate(-cx, -cy);
      final hand1 = Path()
        ..moveTo(cx, cy)
        ..lineTo(cx, cy - r * 0.55);
      canvas.drawPath(_partialPath(hand1, hand1T), paint);
      canvas.restore();
    }

    if (hand2T > 0) {
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(extraAngle);
      canvas.translate(-cx, -cy);
      final hand2 = Path()
        ..moveTo(cx, cy)
        ..lineTo(cx + r * 0.4, cy - r * 0.4);
      canvas.drawPath(_partialPath(hand2, hand2T), paint);
      canvas.restore();
    }

    if (hand2T >= 1) {
      canvas.drawCircle(Offset(cx, cy), 3.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _EmblemPainter oldDelegate) {
    return oldDelegate.drawProgress != drawProgress ||
        oldDelegate.handRotation != handRotation ||
        oldDelegate.color != color;
  }
}

class MonarqLoadingSwitcher extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final String message;
  final Duration showDelay;

  const MonarqLoadingSwitcher({
    Key? key,
    required this.isLoading,
    required this.child,
    this.message = "Loading...",
    this.showDelay = const Duration(milliseconds: 250),
  }) : super(key: key);

  @override
  State<MonarqLoadingSwitcher> createState() => _MonarqLoadingSwitcherState();
}

class _MonarqLoadingSwitcherState extends State<MonarqLoadingSwitcher> {
  bool _showLoader = false;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isLoading) _scheduleLoader();
  }

  @override
  void didUpdateWidget(covariant MonarqLoadingSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _scheduleLoader();
    } else if (!widget.isLoading) {
      _delayTimer?.cancel();
      if (_showLoader) setState(() => _showLoader = false);
    }
  }

  void _scheduleLoader() {
    _delayTimer?.cancel();
    _delayTimer = Timer(widget.showDelay, () {
      if (mounted && widget.isLoading) {
        setState(() => _showLoader = true);
      }
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _showLoader
          ? MonarqLoader(key: const ValueKey("loader"), message: widget.message)
          : KeyedSubtree(key: const ValueKey("content"), child: widget.child),
    );
  }
}
