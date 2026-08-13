import 'package:clothing_app/models/screen_arguements.dart';
import 'package:clothing_app/pages/Category_page.dart';
import 'package:clothing_app/widgets/home/banner_carousel.dart';
import 'package:clothing_app/widgets/home/beauty_section.dart';
import 'package:clothing_app/widgets/home/home_app_bar.dart';
import 'package:clothing_app/widgets/home/product_list_section.dart';
import 'package:clothing_app/widgets/home/promo_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/cart.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  static const List<String> _promoCardImages = [
    "images/card1.png",
    "images/card2.png",
    "images/card3.png",
    "images/card4.png",
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final productdata = Provider.of<Product>(context);
    final prdcts = productdata.items;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(
        cartItemCount: cart.items.length,
        onSearchTap: () {},
        onProfileTap: () => Navigator.pushNamed(context, "/"),
        onCartTap: () => Navigator.pushNamed(context, "/cartscreen"),
      ),
      body: ListView(
        children: [
          const BannerCarousel(
            images: [
              "images/banner1.png",
              "images/banner2.png",
              "images/banner3.png",
            ],
          ),
          const SizedBox(height: 35.0),

          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              minimumSize: MaterialStateProperty.all(const Size(0, 50)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryPage()),
              );
            },
            child: const Text("Our Categories"),
          ).centered(),
          const SizedBox(height: 35.0),

          // 4 promo cards, ab sirf ek loop se
          for (final imagePath in _promoCardImages) ...[
            PromoCard(
              imagePath: imagePath,
              label: "READY TO WEAR",
              onPressed: () {},
            ),
            const SizedBox(height: 35.0),
          ],

          PromoCard(
            imagePath: "images/banner4.png",
            label: "S A L E",
            fontSize: 30,
            width: double.infinity,
            onPressed: () {},
          ),
          const SizedBox(height: 25.0),

          ProductListSection(
            products: prdcts
                .map((p) => ProductItemData(image: p.image, title: p.title))
                .toList(),
          ),
          const SizedBox(height: 25.0),

          BeautySection(
            imagePath: "images/card.jpg",
            title: "BEAUTY & FRAGRANCES",
            description:
                "Create your charm to leave a lasting impression by counting on our captivating and breathtaking fragranirresistible beauty products. Explore the world of our fragrances and beauty range available now!",
            onShopNowTap: () {},
          ),
        ],
      ),
    );
  }
}
