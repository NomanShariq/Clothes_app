import 'package:clothing_app/models/wishlist.dart';
import 'package:clothing_app/pages/product_detail.dart';
import 'package:clothing_app/widgets/home/product_card.dart';
import 'package:clothing_app/widgets/smart_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCollectionPage extends StatefulWidget {
  final List<ProductCardData> allProducts;

  const NewCollectionPage({Key? key, required this.allProducts})
      : super(key: key);

  @override
  State<NewCollectionPage> createState() => _NewCollectionPageState();
}

class _NewCollectionPageState extends State<NewCollectionPage> {
  final List<String> _categories = [
    "All",
    "Dresses",
    "Suits",
    "Kurtas",
    "Shirts",
    "Accessories"
  ];
  String _selectedCategory = "All";

  List<ProductCardData> get _filteredProducts {
    if (_selectedCategory == "All") return widget.allProducts;
    return widget.allProducts
        .where((p) =>
            p.title.toLowerCase().contains(_selectedCategory.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;
    final products = _filteredProducts;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          "New Collection",
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.w600, fontSize: 17),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: primaryColor, size: 22),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.favorite_border, color: primaryColor, size: 22),
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Hero
          Container(
            margin: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: const DecorationImage(
                image: AssetImage("images/ladies.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.65),
                    Colors.black.withValues(alpha: 0.1)
                  ],
                ),
              ),
              padding: const EdgeInsets.all(18),
              alignment: Alignment.centerLeft,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NEW COLLECTION",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Discover the latest styles",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          // Category filters
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = category),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: isSelected ? goldColor : borderColor),
                      color: isSelected
                          ? goldColor.withValues(alpha: 0.12)
                          : Colors.transparent,
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected ? goldColor : grayText,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Latest Arrivals",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: primaryColor),
                    ),
                    const SizedBox(width: 8),
                    Text("${products.length} Products",
                        style: TextStyle(fontSize: 12, color: grayText)),
                  ],
                ),
                Row(
                  children: [
                    _pillButton(context, Icons.tune, "Filter"),
                    const SizedBox(width: 8),
                    _pillButton(context, Icons.sort, "Sort"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: products.isEmpty
                ? _buildEmptyState(context)
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.62,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _CollectionCard(
                        product: product,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetail(product: product)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _pillButton(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: primaryColor),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: primaryColor)),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined,
                size: 70, color: goldColor.withValues(alpha: 0.5)),
            const SizedBox(height: 20),
            Text("No products available",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor)),
            const SizedBox(height: 8),
            Text(
              "New styles will be added soon.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: grayText),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Continue Shopping",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final ProductCardData product;
  final VoidCallback onTap;

  const _CollectionCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final wishlist = Provider.of<Wishlist>(context);
    final isWishlisted = wishlist.isWishlisted(product.title);

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
                    onTap: () => wishlist.toggle(product.title, product),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: isWishlisted ? Colors.red : Colors.black,
                        size: 16,
                      ),
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
                        color: grayText,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
