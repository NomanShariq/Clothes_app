import 'package:flutter/material.dart';

class ComingSoonPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const ComingSoonPage({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 70, color: goldColor.withValues(alpha: 0.6)),
              const SizedBox(height: 20),
              Text(
                "$title Coming Soon",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "This feature is under development and will be available soon.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: grayText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
