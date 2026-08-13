import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BeautySection extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onShopNowTap;

  const BeautySection({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onShopNowTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 245, 207, 204),
      child: Column(
        children: [
          SizedBox(
            height: 400,
            width: 500,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 300,
                width: 400,
              ).centered(),
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 29),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25.0),
          Text(
            description,
            style: const TextStyle(color: Colors.black, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25.0),
          ElevatedButton(
            onPressed: onShopNowTap,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 245, 207, 204)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.black, width: 5.0)),
            ),
            child: const Text(
              "Shop Now",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
