import 'dart:async';
import 'package:flutter/material.dart';

/// Call this after "Place Order" is tapped:
///
///   showOrderConfirmation(
///     context,
///     orderNumber: "MN-10245",
///     onTrackOrder: () { /* navigate to My Orders */ },
///     onContinueShopping: () { /* navigate to Home */ },
///   );
Future<void> showOrderConfirmation(
  BuildContext context, {
  required String orderNumber,
  required VoidCallback onTrackOrder,
  required VoidCallback onContinueShopping,
  String deliveryEstimate = "3–5 business days",
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false, // controlled manually below via _canDismiss
    enableDrag: false,
    builder: (_) => OrderConfirmationSheet(
      orderNumber: orderNumber,
      deliveryEstimate: deliveryEstimate,
      onTrackOrder: onTrackOrder,
      onContinueShopping: onContinueShopping,
    ),
  );
}

enum _Phase { confirmed, packed, shipping, done }

class OrderConfirmationSheet extends StatefulWidget {
  final String orderNumber;
  final String deliveryEstimate;
  final VoidCallback onTrackOrder;
  final VoidCallback onContinueShopping;

  const OrderConfirmationSheet({
    Key? key,
    required this.orderNumber,
    required this.deliveryEstimate,
    required this.onTrackOrder,
    required this.onContinueShopping,
  }) : super(key: key);

  @override
  State<OrderConfirmationSheet> createState() => _OrderConfirmationSheetState();
}

class _OrderConfirmationSheetState extends State<OrderConfirmationSheet>
    with TickerProviderStateMixin {
  _Phase _phase = _Phase.confirmed;
  bool _canDismiss = false;

  late final AnimationController _entryController;
  late final AnimationController _truckController;

  final List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _truckController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Phase 1 -> 2 (Packed) at ~1.0s
    _timers.add(Timer(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() => _phase = _Phase.packed);
    }));

    // Phase 2 -> 3 (Shipping) at ~2.0s, start truck motion
    _timers.add(Timer(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      setState(() => _phase = _Phase.shipping);
      _truckController.forward();
    }));

    // Phase 3 -> 4 (Done) at ~3.6s
    _timers.add(Timer(const Duration(milliseconds: 3600), () {
      if (!mounted) return;
      setState(() {
        _phase = _Phase.done;
        _canDismiss = true;
      });
    }));
  }

  @override
  void dispose() {
    for (final t in _timers) {
      t.cancel();
    }
    _entryController.dispose();
    _truckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gold = theme.colorScheme.secondary;
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final sheetColor = theme.cardColor;

    return PopScope(
      canPop: _canDismiss,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: sheetColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // drag handle (visual only — drag disabled)
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: grayText.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),

              // Top emblem
              ScaleTransition(
                scale: CurvedAnimation(
                  parent: _entryController,
                  curve: Curves.easeOutBack,
                ),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: gold, width: 1.4),
                  ),
                  child: Icon(Icons.diamond_outlined, color: gold, size: 20),
                ),
              ),
              const SizedBox(height: 24),

              // Animated illustration area
              SizedBox(
                height: 140,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween(begin: 0.92, end: 1.0).animate(animation),
                      child: child,
                    ),
                  ),
                  child: _buildIllustration(gold, grayText, primaryColor),
                ),
              ),
              const SizedBox(height: 26),

              // Heading + message (cross-fades with phase)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: Column(
                  key: ValueKey(_phase),
                  children: [
                    Text(
                      _headingFor(_phase),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _messageFor(_phase),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: grayText, fontSize: 13),
                    ),
                  ],
                ),
              ),

              // Order details — only once done
              AnimatedSize(
                duration: const Duration(milliseconds: 350),
                child: _phase == _Phase.done
                    ? Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    (theme.dividerTheme.color ?? Colors.grey)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              _detailRow(
                                  "Order Number",
                                  "#${widget.orderNumber}",
                                  primaryColor,
                                  grayText),
                              const SizedBox(height: 8),
                              _detailRow(
                                  "Estimated Delivery",
                                  widget.deliveryEstimate,
                                  primaryColor,
                                  grayText),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 26),

              // Buttons — only once done
              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: _phase == _Phase.done ? 1 : 0,
                child: IgnorePointer(
                  ignoring: _phase != _Phase.done,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onTrackOrder();
                          },
                          child: const Text(
                            "Track Order",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onContinueShopping();
                        },
                        child: Text(
                          "Continue Shopping",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(
      String label, String value, Color primaryColor, Color grayText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: grayText, fontSize: 12)),
        Text(
          value,
          style: TextStyle(
            color: primaryColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _headingFor(_Phase phase) {
    switch (phase) {
      case _Phase.confirmed:
        return "ORDER CONFIRMED";
      case _Phase.packed:
        return "PACKED WITH CARE";
      case _Phase.shipping:
        return "ON THE WAY";
      case _Phase.done:
        return "ORDER PLACED";
    }
  }

  String _messageFor(_Phase phase) {
    switch (phase) {
      case _Phase.confirmed:
        return "Your order has been successfully placed.";
      case _Phase.packed:
        return "Your order is being prepared for delivery.";
      case _Phase.shipping:
        return "Your MONARQ order is on its way to you.";
      case _Phase.done:
        return "Thank you for shopping with MONARQ.";
    }
  }

  Widget _buildIllustration(Color gold, Color grayText, Color primaryColor) {
    switch (_phase) {
      case _Phase.confirmed:
        return _PackageIllustration(
          key: const ValueKey("confirmed"),
          gold: gold,
          primaryColor: primaryColor,
          showCheck: true,
          showTag: false,
        );
      case _Phase.packed:
        return _PackageIllustration(
          key: const ValueKey("packed"),
          gold: gold,
          primaryColor: primaryColor,
          showCheck: false,
          showTag: true,
        );
      case _Phase.shipping:
        return _TruckIllustration(
          key: const ValueKey("shipping"),
          gold: gold,
          primaryColor: primaryColor,
          grayText: grayText,
          controller: _truckController,
        );
      case _Phase.done:
        return _FinalEmblem(
          key: const ValueKey("done"),
          gold: gold,
          primaryColor: primaryColor,
        );
    }
  }
}

/// Simple minimalist parcel box, optionally with a gold checkmark above
/// (Phase 1) or a small hanging MONARQ tag (Phase 2).
class _PackageIllustration extends StatelessWidget {
  final Color gold;
  final Color primaryColor;
  final bool showCheck;
  final bool showTag;

  const _PackageIllustration({
    Key? key,
    required this.gold,
    required this.primaryColor,
    required this.showCheck,
    required this.showTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 140,
        width: 140,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // box outline
            Container(
              width: 92,
              height: 76,
              decoration: BoxDecoration(
                border: Border.all(
                    color: primaryColor.withOpacity(0.85), width: 1.6),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // box seam (vertical)
            Container(
                width: 1.4, height: 76, color: primaryColor.withOpacity(0.4)),
            // box seam (horizontal fold line near top)
            Positioned(
              top: 44,
              child: Container(
                  width: 92,
                  height: 1.2,
                  color: primaryColor.withOpacity(0.25)),
            ),
            if (showCheck)
              Positioned(
                top: 6,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: gold,
                  ),
                  child: const Icon(Icons.check, color: Colors.black, size: 16),
                ),
              ),
            if (showTag)
              Positioned(
                top: 2,
                right: 30,
                child: Transform.rotate(
                  angle: -0.15,
                  child: Container(
                    width: 26,
                    height: 16,
                    decoration: BoxDecoration(
                      border: Border.all(color: gold, width: 1.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "M",
                      style: TextStyle(
                        color: gold,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Minimalist truck moving left -> right along a thin road line.
class _TruckIllustration extends StatelessWidget {
  final Color gold;
  final Color primaryColor;
  final Color grayText;
  final AnimationController controller;

  const _TruckIllustration({
    Key? key,
    required this.gold,
    required this.primaryColor,
    required this.grayText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 34,
            left: 16,
            right: 16,
            child: Container(height: 1, color: grayText.withOpacity(0.3)),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final curved = CurvedAnimation(
                parent: controller,
                curve: Curves.easeInOut,
              ).value;
              return Positioned(
                bottom: 40,
                left: 16 + curved * 150,
                child: child!,
              );
            },
            child: Icon(Icons.local_shipping_outlined, color: gold, size: 40),
          ),
        ],
      ),
    );
  }
}

/// Final resting emblem — gold check inside a thin ring.
class _FinalEmblem extends StatelessWidget {
  final Color gold;
  final Color primaryColor;

  const _FinalEmblem({
    Key? key,
    required this.gold,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 74,
        height: 74,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: gold, width: 1.4),
        ),
        child: Icon(Icons.check, color: gold, size: 32),
      ),
    );
  }
}
