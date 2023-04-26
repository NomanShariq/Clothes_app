import 'package:clothing_app/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'home__page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          size: 30,
          color: Colors.black,
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Homepage();
                },
              ),
            );
          },
          child: Center(
            child: Image.asset(
              "images/logo.png",
              height: 100,
              width: 250,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('images/profile.jpg'),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Noman Shariq',
                style: TextStyle(
                  fontSize: 36.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Nshariq562@gmail.com',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                width: 300.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Personal Information'),
                      subtitle: const Text('Age: 32 | Gender: Male'),
                      onTap: () {
                        // Navigate to personal information page
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.security),
                      title: const Text('Security'),
                      subtitle: const Text('Last sign in: Yesterday'),
                      onTap: () {
                        // Navigate to security page
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text(
                        'Settings',
                      ),
                      onTap: () {
                        // Navigate to settings page
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Sign Out',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
