import 'package:clothing_app/pages/home__page.dart';
import 'package:clothing_app/pages/login_page.dart';
import 'package:clothing_app/widgets/app_drawer.dart';
import 'package:clothing_app/widgets/app_logo_header.dart';
import 'package:clothing_app/widgets/auth_switch_text.dart';
import 'package:clothing_app/widgets/custom_text_field.dart';
import 'package:clothing_app/widgets/or_divider.dart';
import 'package:clothing_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SignUpPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                const AppLogoHeader(
                  title: "Create Account",
                  subtitle: "Sign up to start shopping",
                ),
                const SizedBox(height: 40),
                const CustomTextField(
                  label: "Full Name",
                  hint: "John Doe",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 22),
                const CustomTextField(
                  label: "Email",
                  hint: "you@example.com",
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 22),
                PasswordField(controller: passwordController),
                const SizedBox(height: 22),
                PasswordField(
                  label: "Confirm Password",
                  hint: "Re-enter password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*Required";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),
                PrimaryButton(text: "Sign Up", onPressed: validate),
                const SizedBox(height: 28),
                const OrDivider(),
                const SizedBox(height: 24),
                AuthSwitchText(
                  question: "Already have an account? ",
                  actionText: "Sign In",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
