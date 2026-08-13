import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PromoCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final double fontSize;
  final VoidCallback onPressed;
  final double height;
  final double? width;

  const PromoCard({
    Key? key,
    required this.imagePath,
    required this.label,
    this.fontSize = 20,
    required this.onPressed,
    this.height = 400,
    this.width = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            ),
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).objectBottomCenter().p64(),
        ),
      ),
    );
  }
}
