import 'package:clothing_app/pages/coming_soon_page.dart';
import 'package:clothing_app/pages/wishlist_page.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;

  const ProfileScreen({Key? key, this.email = ""}) : super(key: key);

  String get _derivedName {
    if (email.isEmpty || !email.contains("@")) return "Guest";
    final namePart = email.split("@").first;
    return namePart.isEmpty
        ? "Guest"
        : namePart[0].toUpperCase() + namePart.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final surfaceColor = theme.cardColor;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: surfaceColor,
                  child: Text(
                    _derivedName[0],
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildInfoTile(
                context: context,
                label: "Name",
                value: _derivedName,
              ),
              const SizedBox(height: 16),
              _buildInfoTile(context: context, label: "Email", value: email),
              const SizedBox(height: 28),
              _accountRow(
                context: context,
                icon: Icons.receipt_long_outlined,
                title: "My Orders",
                subtitle: "Track and manage your orders",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComingSoonPage(
                      title: "My Orders",
                      icon: Icons.receipt_long_outlined,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _accountRow(
                context: context,
                icon: Icons.favorite_border,
                title: "Wishlist",
                subtitle: "Your saved products",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WishlistPage()),
                ),
              ),
              const SizedBox(height: 10),
              _accountRow(
                context: context,
                icon: Icons.location_on_outlined,
                title: "Addresses",
                subtitle: "Manage delivery addresses",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComingSoonPage(
                      title: "Addresses",
                      icon: Icons.location_on_outlined,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _accountRow(
                context: context,
                icon: Icons.credit_card_outlined,
                title: "Payment Methods",
                subtitle: "Manage your payment options",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComingSoonPage(
                      title: "Payment Methods",
                      icon: Icons.credit_card_outlined,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _accountRow(
                context: context,
                icon: Icons.settings_outlined,
                title: "Settings",
                subtitle: "App preferences",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComingSoonPage(
                      title: "Settings",
                      icon: Icons.settings_outlined,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/",
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.grey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: theme.textTheme.bodyMedium?.color ?? Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value.isEmpty ? "-" : value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountRow({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: grayText),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: TextStyle(fontSize: 11, color: grayText)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 20, color: grayText),
          ],
        ),
      ),
    );
  }
}
