import 'package:flutter/material.dart';

class ProductItemData {
  final String image;
  final String title;

  ProductItemData({required this.image, required this.title});
}

class ProductListSection extends StatelessWidget {
  final List<ProductItemData> products;

  const ProductListSection({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  product.image,
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
