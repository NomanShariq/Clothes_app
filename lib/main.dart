import 'package:clothing_app/models/cart.dart';
import 'package:clothing_app/models/screen_arguements.dart';
import 'package:clothing_app/pages/home_page.dart';
import 'package:clothing_app/pages/login_page.dart';
import 'package:clothing_app/screens/cart_screen.dart';
import 'package:clothing_app/screens/pdct_detail_screen.dart';
import 'package:clothing_app/theme/app_theme.dart';
import 'package:clothing_app/theme/theme_provider.dart';
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
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              initialRoute: "/home",
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.linear(1.0)),
                  child: child!,
                );
              },
              routes: {
                "/": (context) => const LoginPage(),
                "/home": (context) => const Homepage(),
                "/detail": (context) => const DetailPage(),
                "/cartscreen": (context) => const CartScreen(),
              });
        },
      ),
    );
  }
}
