import 'package:clothing_app/pages/Category_page.dart';
import 'package:clothing_app/pages/all_products.dart';
import 'package:clothing_app/pages/login_page.dart';
import 'package:clothing_app/pages/profile_page.dart';
import 'package:clothing_app/pages/setting_page.dart';
import 'package:flutter/material.dart';
import '../pages/home__page.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final List<Widget> _pages = [
    Homepage(),
    ProfilePage(),
    const Allproducts(),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: 320,
              color: const Color.fromARGB(255, 27, 27, 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'images/profile.jpg',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Noman Shariq',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Nshariq562@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => Homepage()),
                ),
              ),
            ),
            ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => ProfilePage()),
                ),
              ),
              leading: const Icon(Icons.person),
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
             ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => SettingsPage()),
                ),
              ),
              leading: const Icon(Icons.settings),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => LoginPage()),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
