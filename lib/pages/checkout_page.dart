import 'package:clothing_app/models/cart.dart';
import 'package:clothing_app/utils/currency.dart';
import 'package:clothing_app/widgets/order_confirmation_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DeliveryMethod { standard, express }

enum PaymentMethod { cod, card }

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  DeliveryMethod _selectedDelivery = DeliveryMethod.standard;
  PaymentMethod _selectedPayment = PaymentMethod.cod;

  int get _deliveryFee =>
      _selectedDelivery == DeliveryMethod.standard ? 200 : 400;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();
    final subtotal = cart.subtotal;
    final discount = cart.totalDiscount;
    final total = (subtotal - discount) + _deliveryFee;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          "Checkout",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
            fontSize: 17,
            letterSpacing: 0.3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(context, "DELIVERY ADDRESS"),
            const SizedBox(height: 10),
            _addressCard(context),
            const SizedBox(height: 24),
            _sectionTitle(context, "DELIVERY METHOD"),
            const SizedBox(height: 10),
            _deliveryOption(
              context: context,
              method: DeliveryMethod.standard,
              title: "Standard Delivery",
              subtitle: "3–5 Business Days",
              price: "Rs 200",
            ),
            const SizedBox(height: 10),
            _deliveryOption(
              context: context,
              method: DeliveryMethod.express,
              title: "Express Delivery",
              subtitle: "1–2 Business Days",
              price: "Rs 400",
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, "PAYMENT METHOD"),
            const SizedBox(height: 10),
            _paymentOption(
              context: context,
              method: PaymentMethod.cod,
              icon: Icons.payments_outlined,
              title: "Cash on Delivery",
              enabled: true,
            ),
            const SizedBox(height: 10),
            _paymentOption(
              context: context,
              method: PaymentMethod.card,
              icon: Icons.credit_card_outlined,
              title: "Credit / Debit Card",
              enabled: false,
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, "ORDER ITEMS"),
            const SizedBox(height: 10),
            for (final item in items) ...[
              _orderItemRow(context, item),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 14),
            _sectionTitle(context, "ORDER SUMMARY"),
            const SizedBox(height: 12),
            _summaryRow(context, "Subtotal", formatCurrency(subtotal)),
            if (discount > 0)
              _summaryRow(context, "Discount", "- ${formatCurrency(discount)}",
                  valueColor: Theme.of(context).colorScheme.secondary),
            _summaryRow(context, "Delivery", formatCurrency(_deliveryFee)),
            const SizedBox(height: 8),
            Divider(color: Theme.of(context).dividerTheme.color, height: 1),
            const SizedBox(height: 12),
            _summaryRow(context, "Total", formatCurrency(total), isTotal: true),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
              top: BorderSide(
                  color: Theme.of(context).dividerTheme.color ?? Colors.grey)),
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
                    Text("Total",
                        style: TextStyle(
                            fontSize: 12,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color ??
                                    Colors.grey)),
                    Text(
                      formatCurrency(total),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 170,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    showOrderConfirmation(
                      context,
                      orderNumber: "MN-10245",
                      deliveryEstimate: "3–5 business days",
                      onTrackOrder: () {
                        // TODO: Navigate to My Orders screen
                      },
                      onContinueShopping: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    );
                  },
                  child: const Text(
                    "Place Order",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    final grayText =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
    return Text(
      text,
      style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          color: grayText),
    );
  }

  Widget _addressCard(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on_outlined, color: goldColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Noman Shariq",
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                const SizedBox(height: 4),
                Text("+92 3XX XXX XXXX",
                    style: TextStyle(color: grayText, fontSize: 12)),
                const SizedBox(height: 4),
                Text(
                  "House 24, Block 5, Gulshan-e-Iqbal, Karachi",
                  style: TextStyle(color: grayText, fontSize: 12),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text("Change",
                style: TextStyle(
                    color: goldColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _deliveryOption({
    required BuildContext context,
    required DeliveryMethod method,
    required String title,
    required String subtitle,
    required String price,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;

    final isSelected = _selectedDelivery == method;
    return GestureDetector(
      onTap: () => setState(() => _selectedDelivery = method),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? goldColor : borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(height: 3),
                  Text(subtitle,
                      style: TextStyle(color: grayText, fontSize: 12)),
                ],
              ),
            ),
            Text(price,
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
            const SizedBox(width: 12),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? goldColor : grayText,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption({
    required BuildContext context,
    required PaymentMethod method,
    required IconData icon,
    required String title,
    required bool enabled,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;

    final isSelected = _selectedPayment == method;
    return GestureDetector(
      onTap: enabled ? () => setState(() => _selectedPayment = method) : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: isSelected && enabled ? goldColor : borderColor),
          ),
          child: Row(
            children: [
              Icon(icon, color: grayText, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title,
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
              ),
              if (enabled)
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected ? goldColor : grayText,
                  size: 20,
                )
              else
                Text("Coming Soon",
                    style: TextStyle(color: grayText, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderItemRow(BuildContext context, Cartitem item) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(item.image,
                width: 50, height: 56, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                const SizedBox(height: 3),
                Text(
                  "${item.size != null ? 'Size: ${item.size}  •  ' : ''}Qty: ${item.quantity}",
                  style: TextStyle(color: grayText, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            formatCurrency(item.price * item.quantity),
            style: TextStyle(
                color: primaryColor, fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value,
      {bool isTotal = false, Color? valueColor}) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal ? primaryColor : grayText,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 20 : 13,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: valueColor ?? (isTotal ? goldColor : primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
