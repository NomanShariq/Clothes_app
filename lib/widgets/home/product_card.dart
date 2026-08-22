import 'package:clothing_app/widgets/smart_image.dart';
import 'package:flutter/material.dart';

class ProductCardData {
  final String image;
  final String title;
  final double rating;
  final double price;
  final double? originalPrice;
  final String description;

  const ProductCardData({
    required this.image,
    required this.title,
    required this.rating,
    required this.price,
    this.originalPrice,
    this.description = "",
  });

  bool get isOnSale => originalPrice != null && originalPrice! > price;

  factory ProductCardData.fromJson(Map<String, dynamic> json, String baseUrl) {
    String imageUrl = json['image'] ?? '';
    if (!imageUrl.startsWith('http')) {
      imageUrl = "$baseUrl$imageUrl";
    }
    return ProductCardData(
      image: imageUrl,
      title: json['name'],
      rating: double.tryParse(json['rating'].toString()) ?? 4.5,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['original_price'] != null
          ? (json['original_price'] as num).toDouble()
          : null,
      description: json['description'] ?? "",
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductCardData product;
  final VoidCallback onTap;

  const ProductCard({Key? key, required this.product, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      child: const Text(
                        "SALE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
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
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 13),
              const SizedBox(width: 3),
              Text(
                product.rating.toStringAsFixed(1),
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                "Rs ${product.price.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
                      decoration: TextDecoration.lineThrough,
                    ),
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
