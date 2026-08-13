import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartItemCount;
  final VoidCallback onSearchTap;
  final VoidCallback onProfileTap;
  final VoidCallback onCartTap;

  const HomeAppBar({
    Key? key,
    required this.cartItemCount,
    required this.onSearchTap,
    required this.onProfileTap,
    required this.onCartTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Image(
        width: 230,
        image: AssetImage("images/logo.png"),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: onSearchTap,
            child: const Icon(Icons.search, size: 26.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: onProfileTap,
            child: const Icon(Icons.account_circle, size: 26.0),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart)
              .badge(color: Colors.grey, count: cartItemCount),
          onPressed: onCartTap,
        ),
      ],
    );
  }
}
