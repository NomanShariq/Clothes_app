import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerCarousel extends StatelessWidget {
  final List<String> images;
  final double height;

  const BannerCarousel({
    Key? key,
    required this.images,
    this.height = 400.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          height: height,
          viewportFraction: 1.0,
          autoPlay: true,
          enlargeCenterPage: false,
        ),
        items: images.map((imagePath) {
          return Builder(
            builder: (BuildContext context) {
              return Image.asset(
                imagePath,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
