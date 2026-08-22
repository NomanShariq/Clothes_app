import 'package:clothing_app/widgets/smart_image.dart';
import 'package:flutter/material.dart';

class CategoryItem {
  final String label;
  final String imagePath;

  const CategoryItem({required this.label, required this.imagePath});
}

class CategoryIconsRow extends StatelessWidget {
  final List<CategoryItem> categories;
  final void Function(CategoryItem) onTap;

  const CategoryIconsRow({
    Key? key,
    required this.categories,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: categories.map((category) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () => onTap(category),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: SmartImage(
                            path: category.imagePath, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      category.label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
