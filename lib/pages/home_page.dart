import 'package:clothing_app/models/user_session.dart';
import 'package:clothing_app/pages/category_detail_page.dart';
import 'package:clothing_app/pages/profile_screen.dart';
import 'package:clothing_app/pages/sale_page.dart';
import 'package:clothing_app/widgets/home/app_bottom_nav.dart';
import 'package:clothing_app/widgets/home/category_icons_row.dart';
import 'package:clothing_app/widgets/home/hero_banner.dart';
import 'package:clothing_app/widgets/home/home_app_bar.dart';
import 'package:clothing_app/widgets/home/product_card.dart';
import 'package:clothing_app/widgets/home/section_header.dart';
import 'package:flutter/material.dart';

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

  static const List<ProductCardData> _ladiesProducts = [
    ProductCardData(
        image: _ladiesImage, title: "Ladies Kurti", rating: 4.5, price: 4500),
    ProductCardData(
        image: _ladiesImage,
        title: "Embroidered Suit",
        rating: 4.7,
        price: 4900,
        originalPrice: 6900),
    ProductCardData(
        image: _ladiesImage, title: "Lawn 3-Piece", rating: 4.3, price: 5200),
    ProductCardData(
        image: _ladiesImage,
        title: "Party Wear",
        rating: 4.8,
        price: 6900,
        originalPrice: 8900),
  ];

  static const List<ProductCardData> _gentsProducts = [
    ProductCardData(
        image: _gentsImage,
        title: "Men Denim Shirt",
        rating: 4.5,
        price: 7500,
        originalPrice: 9500),
    ProductCardData(
        image: _gentsImage, title: "Denim Jeans", rating: 4.6, price: 19500),
    ProductCardData(
        image: _gentsImage,
        title: "Black Shalwar Suit",
        rating: 4.4,
        price: 29900,
        originalPrice: 38900),
    ProductCardData(
        image: _gentsImage, title: "Formal Shirt", rating: 4.2, price: 5900),
  ];

  static const List<ProductCardData> _kidsProducts = [
    ProductCardData(
        image: _kidsImage,
        title: "Kids Festive Frock",
        rating: 4.9,
        price: 2500,
        originalPrice: 3500),
    ProductCardData(
        image: _kidsImage, title: "Kids Casual Wear", rating: 4.5, price: 2900),
    ProductCardData(
        image: _kidsImage,
        title: "Kids Party Dress",
        rating: 4.7,
        price: 2900,
        originalPrice: 4200),
    ProductCardData(
        image: _kidsImage, title: "Kids T-Shirt", rating: 4.3, price: 1800),
  ];

  List<ProductCardData> get _saleProducts => [
        ..._ladiesProducts.where((p) => p.isOnSale),
        ..._gentsProducts.where((p) => p.isOnSale),
        ..._kidsProducts.where((p) => p.isOnSale),
      ];

  List<ProductCardData> _productsForLabel(String label) {
    switch (label) {
      case "Ladies":
        return _ladiesProducts;
      case "Gents":
        return _gentsProducts;
      case "Kids":
        return _kidsProducts;
      default:
        return [];
    }
  }

  Widget _buildProductSection({
    required String title,
    required List<ProductCardData> products,
    bool isSale = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          onViewAll: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => isSale
                    ? SalePage(products: products)
                    : CategoryDetailPage(title: title, products: products),
              ),
            );
          },
        ),
        SizedBox(
          height: 245,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 8),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ProductCard(
                  product: products[index],
                  onTap: () {},
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(onSearchTap: () {}),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (index) {
          setState(() => _navIndex = index);
          if (index == 2) {
            Navigator.pushNamed(context, "/cartscreen");
          } else if (index == 3) {
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
                MaterialPageRoute(
                  builder: (context) => CategoryDetailPage(
                    title: category.label,
                    products: _productsForLabel(category.label),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          HeroBanner(
            imagePath: _ladiesImage,
            onShopNow: () {},
          ),
          const SizedBox(height: 8),
          _buildProductSection(
              title: "HOT DEALS", products: _saleProducts, isSale: true),
          _buildProductSection(title: "LADIES WEAR", products: _ladiesProducts),
          _buildProductSection(title: "GENTS WEAR", products: _gentsProducts),
          _buildProductSection(title: "KIDS WEAR", products: _kidsProducts),
        ],
      ),
    );
  }
}
