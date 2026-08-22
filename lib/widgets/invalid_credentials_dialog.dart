import 'dart:math' as math;
import 'package:flutter/material.dart';

bool _isInvalidCredentialsDialogOpen = false;

/// Shows the branded "Invalid Credentials" animated dialog.
/// Safe to call repeatedly — if one is already visible, this is a no-op,
/// preventing duplicate dialogs from rapid repeated Sign In taps.
Future<void> showInvalidCredentialsDialog(BuildContext context) async {
  if (_isInvalidCredentialsDialogOpen) return;
  _isInvalidCredentialsDialogOpen = true;

  await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Invalid Credentials",
    barrierColor: Colors.black.withOpacity(0.55),
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const _InvalidCredentialsDialog();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(begin: 0.9, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );

  _isInvalidCredentialsDialogOpen = false;
}

class _InvalidCredentialsDialog extends StatefulWidget {
  const _InvalidCredentialsDialog({Key? key}) : super(key: key);

  @override
  State<_InvalidCredentialsDialog> createState() =>
      _InvalidCredentialsDialogState();
}

class _InvalidCredentialsDialogState extends State<_InvalidCredentialsDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
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
    final primaryColor = theme.colorScheme.primary;
    final gold = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;
    const errorRed = Color(0xFFB33A3A); // restrained, not a loud red

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        padding: const EdgeInsets.fromLTRB(28, 32, 28, 24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final t = _controller.value;
                final circleT = _localT(t, 0.0, 0.45);
                final iconT = _localT(t, 0.35, 0.55);
                final shakeT = _localT(t, 0.55, 0.78);
                final particleT = _localT(t, 0.6, 0.85);
                final particleFadeT = _localT(t, 0.85, 1.0);

                // decaying horizontal shake
                double shakeOffset = 0;
                if (shakeT > 0 && shakeT < 1) {
                  final decay = 1 - shakeT;
                  shakeOffset = math.sin(shakeT * math.pi * 6) * 6 * decay;
                }

                double particleOpacity = 0;
                if (particleT > 0) {
                  particleOpacity =
                      particleFadeT > 0 ? (1 - particleFadeT) : particleT;
                }

                return SizedBox(
                  width: 84,
                  height: 84,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // circular outline draw
                      CustomPaint(
                        size: const Size(84, 84),
                        painter: _CircleDrawPainter(
                          progress: circleT,
                          color: errorRed,
                        ),
                      ),
                      // particles
                      if (particleOpacity > 0) ...[
                        Positioned(
                          top: 8,
                          right: 10,
                          child: Opacity(
                            opacity: particleOpacity,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: gold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 6,
                          child: Opacity(
                            opacity: particleOpacity,
                            child: Container(
                              width: 10,
                              height: 2,
                              decoration: BoxDecoration(
                                color: errorRed.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ),
                      ],
                      // lock icon, fades in, then shakes
                      Transform.translate(
                        offset: Offset(shakeOffset, 0),
                        child: Opacity(
                          opacity: iconT,
                          child: Icon(
                            Icons.lock_outline,
                            color: errorRed,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 22),
            Text(
              "Invalid Credentials",
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "The email or password you entered is incorrect. Please check your details and try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: grayText,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Try Again",
                  style: TextStyle(
                    color: theme.colorScheme.onSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: () {
                // Forgot-password flow not implemented yet.
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: grayText,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleDrawPainter extends CustomPainter {
  final double progress; // 0 -> 1
  final Color color;

  _CircleDrawPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2 - 2,
    );

    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleDrawPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
