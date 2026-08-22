import 'package:clothing_app/models/cart.dart';
import 'package:clothing_app/models/wishlist.dart';
import 'package:clothing_app/pages/product_detail.dart';
import 'package:clothing_app/widgets/home/product_card.dart';
import 'package:clothing_app/widgets/smart_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  void _addToCart(BuildContext context, ProductCardData product) {
    final cart = Provider.of<Cart>(context, listen: false);
    cart.addItem(
      product.title,
      product.title,
      product.price.round(),
      originalPrice: product.originalPrice?.round(),
      image: product.image,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Added to Cart"),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<Wishlist>(context);
    final items = wishlist.items;
    final keys = items.keys.toList();
    final products = items.values.toList();
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          "Wishlist${items.isNotEmpty ? ' (${items.length})' : ''}",
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: items.isEmpty
          ? _buildEmptyState(context, primaryColor)
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                final key = keys[index];
                return _WishlistCard(
                  product: product,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetail(product: product)),
                  ),
                  onHeartTap: () => wishlist.remove(key),
                  onAddToCart: () => _addToCart(context, product),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context, Color primaryColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 90, color: Colors.grey.shade300),
            const SizedBox(height: 24),
            Text(
              "Your Wishlist is Empty",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              "Save your favorite styles here and find them easily later.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                ),
                onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                child: const Text("Continue Shopping",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final ProductCardData product;
  final VoidCallback onTap;
  final VoidCallback onHeartTap;
  final VoidCallback onAddToCart;

  const _WishlistCard({
    required this.product,
    required this.onTap,
    required this.onHeartTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SmartImage(path: product.image, fit: BoxFit.cover),
                ),
                if (product.isOnSale)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text("SALE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onHeartTap,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.favorite,
                          color: Colors.red, size: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: primaryColor),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 13),
              const SizedBox(width: 3),
              Text(product.rating.toStringAsFixed(1),
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "Rs ${product.price.toStringAsFixed(0)}",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              if (product.isOnSale) ...[
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    "Rs ${product.originalPrice!.toStringAsFixed(0)}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: onAddToCart,
              child: Text("Add to Cart",
                  style: TextStyle(fontSize: 11, color: primaryColor)),
            ),
          ),
        ],
      ),
    );
  }
}
