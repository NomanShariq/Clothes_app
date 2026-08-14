import 'package:clothing_app/models/user_session.dart';
import 'package:clothing_app/pages/Category_page.dart';
import 'package:clothing_app/pages/profile_screen.dart';
import 'package:clothing_app/widgets/home/app_bottom_nav.dart';
import 'package:clothing_app/widgets/home/category_icons_row.dart';
import 'package:clothing_app/widgets/home/hero_banner.dart';
import 'package:clothing_app/widgets/home/home_app_bar.dart';
import 'package:clothing_app/widgets/home/media_banner_carousel.dart'
    show MediaBannerCarousel, MediaType, MediaBannerItem;
import 'package:clothing_app/widgets/home/product_card.dart';
import 'package:clothing_app/widgets/home/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

const String _ladiesImage = "images/ladies.jpg";
const String _gentsImage = "images/gents.jpg";
const String _kidsImage = "images/kids.jpg";

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _navIndex = 0;

  static const List<CategoryItem> _categories = [
    CategoryItem(label: "Ladies", imagePath: _ladiesImage),
    CategoryItem(label: "Gents", imagePath: _gentsImage),
    CategoryItem(label: "Kids", imagePath: _kidsImage),
  ];

  // Placeholder product lists — replace image/title/price later with real data
  static const List<ProductCardData> _ladiesProducts = [
    ProductCardData(
        image: _ladiesImage, title: "Ladies Kurti", rating: 4.5, price: 4500),
    ProductCardData(
        image: _ladiesImage,
        title: "Embroidered Suit",
        rating: 4.7,
        price: 6900),
    ProductCardData(
        image: _ladiesImage, title: "Lawn 3-Piece", rating: 4.3, price: 5200),
    ProductCardData(
        image: _ladiesImage, title: "Party Wear", rating: 4.8, price: 8900),
  ];

  static const List<ProductCardData> _gentsProducts = [
    ProductCardData(
        image: _gentsImage, title: "Men Denim Shirt", rating: 4.5, price: 9500),
    ProductCardData(
        image: _gentsImage, title: "Denim Jeans", rating: 4.6, price: 19500),
    ProductCardData(
        image: _gentsImage,
        title: "Black Shalwar Suit",
        rating: 4.4,
        price: 38900),
    ProductCardData(
        image: _gentsImage, title: "Formal Shirt", rating: 4.2, price: 5900),
  ];

  static const List<ProductCardData> _kidsProducts = [
    ProductCardData(
        image: _kidsImage,
        title: "Kids Festive Frock",
        rating: 4.9,
        price: 3500),
    ProductCardData(
        image: _kidsImage, title: "Kids Casual Wear", rating: 4.5, price: 2900),
    ProductCardData(
        image: _kidsImage, title: "Kids Party Dress", rating: 4.7, price: 4200),
    ProductCardData(
        image: _kidsImage, title: "Kids T-Shirt", rating: 4.3, price: 1800),
  ];

  Widget _buildProductSection({
    required String title,
    required List<ProductCardData> products,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          onViewAll: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoryPage()),
            );
          },
        ),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: products[index],
                onTap: () {},
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(
        cartItemCount: cart.items.length,
        onSearchTap: () {},
        onProfileTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(email: UserSession.email),
          ),
        ),
        onCartTap: () => Navigator.pushNamed(context, "/cartscreen"),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (index) {
          setState(() => _navIndex = index);
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(email: UserSession.email),
              ),
            );
          }
        },
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          CategoryIconsRow(
            categories: _categories,
            onTap: (category) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryPage()),
              );
            },
          ),
          const SizedBox(height: 24),
          const MediaBannerCarousel(
            items: [
              MediaBannerItem(type: MediaType.image, path: _ladiesImage),
              MediaBannerItem(type: MediaType.video, path: "videos/promo1.mp4"),
              MediaBannerItem(type: MediaType.image, path: _gentsImage),
              MediaBannerItem(type: MediaType.video, path: "videos/promo2.mp4"),
            ],
          ),
          const SizedBox(height: 24),
          _buildProductSection(title: "LADIES WEAR", products: _ladiesProducts),
          _buildProductSection(title: "GENTS WEAR", products: _gentsProducts),
          _buildProductSection(title: "KIDS WEAR", products: _kidsProducts),
        ],
      ),
    );
  }
}
