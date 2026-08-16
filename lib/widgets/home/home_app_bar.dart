import 'package:clothing_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSearchTap;

  const HomeAppBar({
    Key? key,
    required this.onSearchTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      titleSpacing: 20,
      title: Text(
        "BONANZA SATRANGI",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, size: 24),
          onPressed: onSearchTap,
        ),
        IconButton(
          icon: Icon(
            themeProvider.isDarkMode(context)
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
            size: 24,
          ),
          onPressed: () =>
              themeProvider.toggleTheme(!themeProvider.isDarkMode(context)),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
