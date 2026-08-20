import 'package:clothing_app/models/cart.dart';
import 'package:clothing_app/pages/checkout_page.dart';
import 'package:clothing_app/utils/currency.dart';
import 'package:clothing_app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();
  String? _promoMessage;
  bool _promoSuccess = false;

  void _applyPromo() {
    setState(() {
      if (_promoController.text.trim().toUpperCase() == "SALE10") {
        _promoSuccess = true;
        _promoMessage = "Promo code applied!";
      } else {
        _promoSuccess = false;
        _promoMessage = "Invalid promo code";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.items;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          "My Cart",
          // "My Cart${items.isNotEmpty ? ' (${cart.itemCount})' : ''}",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: items.isEmpty
          ? _buildEmptyState(context)
          : _buildCartContent(context, cart),
      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade600),
                          ),
                          Text(
                            formatCurrency(cart.total),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckoutPage()),
                          );
                        },
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag_outlined,
                size: 90, color: Colors.grey.shade300),
            const SizedBox(height: 24),
            Text(
              "Your Cart is Empty",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              "Looks like you haven't added anything yet.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Continue Shopping",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, Cart cart) {
    final keys = cart.items.keys.toList();
    final values = cart.items.values.toList();
    final primaryColor = Theme.of(context).colorScheme.primary;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.add, size: 16, color: primaryColor),
              label: Text(
                "Continue Shopping",
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          for (int i = 0; i < keys.length; i++)
            CartPdt(productId: keys[i], item: values[i]),
          const SizedBox(height: 8),
          Text(
            "Have a promo code?",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: primaryColor),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoController,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    hintText: "Enter promo code",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 46,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _applyPromo,
                  child: Text("Apply", style: TextStyle(color: primaryColor)),
                ),
              ),
            ],
          ),
          if (_promoMessage != null) ...[
            const SizedBox(height: 6),
            Text(
              _promoMessage!,
              style: TextStyle(
                fontSize: 12,
                color: _promoSuccess ? Colors.green : Colors.red,
              ),
            ),
          ],
          const SizedBox(height: 24),
          Text(
            "ORDER SUMMARY",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: primaryColor),
          ),
          const SizedBox(height: 12),
          _summaryRow(context, "Subtotal", formatCurrency(cart.subtotal)),
          if (cart.totalDiscount > 0)
            _summaryRow(
                context, "Discount", "- ${formatCurrency(cart.totalDiscount)}",
                valueColor: Colors.green),
          _summaryRow(
            context,
            "Delivery",
            cart.deliveryFee == 0 ? "Free" : formatCurrency(cart.deliveryFee),
          ),
          const Divider(height: 24),
          _summaryRow(context, "Total", formatCurrency(cart.total),
              isTotal: true),
          const SizedBox(height: 12),
          if (cart.deliveryFee > 0)
            Text(
              "Add ${formatCurrency(5000 - cart.amountAfterDiscount)} more for FREE delivery",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            )
          else
            Row(
              children: [
                Icon(Icons.check_circle,
                    size: 16, color: Colors.green.shade600),
                const SizedBox(width: 6),
                Text(
                  "You qualify for FREE delivery",
                  style: TextStyle(fontSize: 12, color: Colors.green.shade700),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value,
      {bool isTotal = false, Color? valueColor}) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? primaryColor : Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 17 : 13,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color:
                  valueColor ?? (isTotal ? primaryColor : Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }
}
