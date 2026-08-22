import 'package:clothing_app/models/user_session.dart';
import 'package:clothing_app/pages/category_detail_page.dart';
import 'package:clothing_app/pages/new_collection_page.dart';
import 'package:clothing_app/pages/product_detail.dart' show ProductDetail;
import 'package:clothing_app/pages/profile_screen.dart';
import 'package:clothing_app/pages/sale_page.dart';
import 'package:clothing_app/pages/search_page.dart';
import 'package:clothing_app/pages/wishlist_page.dart';
import 'package:clothing_app/services/api_services.dart';
import 'package:clothing_app/widgets/home/app_bottom_nav.dart';
import 'package:clothing_app/widgets/home/category_icons_row.dart';
import 'package:clothing_app/widgets/home/hero_banner.dart';
import 'package:clothing_app/widgets/home/home_app_bar.dart';
import 'package:clothing_app/widgets/home/product_card.dart';
import 'package:clothing_app/widgets/home/section_header.dart';
import 'package:clothing_app/widgets/monarq_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  bool _isSplashLoading = true;
  bool _isProductsLoading = true;

  List<ProductCardData> _ladiesProducts = [];
  List<ProductCardData> _gentsProducts = [];
  List<ProductCardData> _kidsProducts = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _isSplashLoading = false);
    });
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final allProducts = await ApiService.fetchProducts();
      final imageBaseUrl = dotenv.env['MEDIA_BASE_URL'] ?? '';
      setState(() {
        _ladiesProducts = allProducts
            .where((p) => p['category'] == 'Ladies')
            .map((p) => ProductCardData.fromJson(p, imageBaseUrl))
            .toList();
        _gentsProducts = allProducts
            .where((p) => p['category'] == 'Gents')
            .map((p) => ProductCardData.fromJson(p, imageBaseUrl))
            .toList();
        _kidsProducts = allProducts
            .where((p) => p['category'] == 'Kids')
            .map((p) => ProductCardData.fromJson(p, imageBaseUrl))
            .toList();
        _isProductsLoading = false;
      });
    } catch (e) {
      setState(() => _isProductsLoading = false);
      debugPrint("Error loading products: $e");
    }
  }

  static const List<CategoryItem> _categories = [
    CategoryItem(label: "Ladies", imagePath: _ladiesImage),
    CategoryItem(label: "Gents", imagePath: _gentsImage),
    CategoryItem(label: "Kids", imagePath: _kidsImage),
  ];

  List<ProductCardData> get _saleProducts => [
        ..._ladiesProducts.where((p) => p.isOnSale),
        ..._gentsProducts.where((p) => p.isOnSale),
        ..._kidsProducts.where((p) => p.isOnSale),
      ];

  List<ProductCardData> get _allProducts => [
        ..._ladiesProducts,
        ..._gentsProducts,
        ..._kidsProducts,
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
                child: SizedBox(
                  width: 155,
                  child: ProductCard(
                    product: products[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetail(product: products[index]),
                        ),
                      );
                    },
                  ),
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: HomeAppBar(
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(allProducts: _allProducts),
            ),
          );
        },
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (index) {
          setState(() => _navIndex = index);
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistPage()),
            ).then((_) => setState(() => _navIndex = 0));
          } else if (index == 2) {
            Navigator.pushNamed(context, "/cartscreen")
                .then((_) => setState(() => _navIndex = 0));
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(email: UserSession.email),
              ),
            ).then((_) => setState(() => _navIndex = 0));
          }
        },
      ),
      body: MonarqLoadingSwitcher(
        isLoading: _isSplashLoading || _isProductsLoading,
        message: "Curating your style...",
        child: ListView(
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
              onShopNow: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewCollectionPage(allProducts: _allProducts),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _buildProductSection(
                title: "HOT DEALS", products: _saleProducts, isSale: true),
            _buildProductSection(
                title: "LADIES WEAR", products: _ladiesProducts),
            _buildProductSection(title: "GENTS WEAR", products: _gentsProducts),
            _buildProductSection(title: "KIDS WEAR", products: _kidsProducts),
          ],
        ),
      ),
    );
  }
}
