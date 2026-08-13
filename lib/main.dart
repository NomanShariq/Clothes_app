import 'package:clothing_app/models/cart.dart';
import 'package:clothing_app/models/screen_arguements.dart';
import 'package:clothing_app/pages/all_products.dart';
import 'package:clothing_app/pages/home__page.dart';
import 'package:clothing_app/pages/login_page.dart';
import 'package:clothing_app/pages/Category_page.dart';
import 'package:clothing_app/screens/cart_screen.dart';
import 'package:clothing_app/screens/pdct_detail_screen.dart';
import 'package:clothing_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Product(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: "/",
        routes: {
          "/": (context) => LoginPage(),
          "/home": (context) => const Homepage(),
          "/category": (context) => const CategoryPage(),
          "/detail": (context) => const DetailPage(),
          // "/cart":(context) => Cartscreen(),
          "/allproducts": (context) => const Allproducts(),
          "/cartscreen": (context) => const CartScreen(),
        },
      ),
    );
  }
}
