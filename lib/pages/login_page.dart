import 'package:clothing_app/pages/signup_page.dart';
import 'package:flutter/material.dart';

import 'home__page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // form is valid, submit the data
      // here you can handle the form data according to your use case
      print('Email: $_email');
      print('Password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          size: 30,
          color: Colors.black,
        ),
        title: Center(
          child: Image.asset(
            "images/logo.png",
            height: 100,
            width: 250,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Account",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40),
              ),
              const Text(
                "Login.",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              const Text(
                "If you have an account with us, please log in.",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(130, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blueGrey.shade800),
                  ),
                  // onPressed: _submitForm,
                  onPressed: () {
                    /*------- validate----------*/
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
                  },
                  child: const Text('Log In'),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
