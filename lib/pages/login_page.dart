import 'package:clothing_app/models/user_session.dart';
import 'package:clothing_app/pages/home_page.dart';
import 'package:clothing_app/pages/profile_screen.dart';
import 'package:clothing_app/pages/sign_up_page.dart';
import 'package:clothing_app/widgets/app_drawer.dart';
import 'package:clothing_app/widgets/app_logo_header.dart';
import 'package:clothing_app/widgets/auth_switch_text.dart';
import 'package:clothing_app/widgets/custom_text_field.dart'
    show CustomTextField, PasswordField;
import 'package:clothing_app/widgets/or_divider.dart';
import 'package:clothing_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      UserSession.email = emailController.text.trim();
      Navigator.pushReplacement(
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
                  title: "Welcome Back",
                  subtitle: "Sign in to continue shopping",
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  label: "Email",
                  hint: "you@example.com",
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                const SizedBox(height: 22),
                PasswordField(controller: passwordController),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryButton(text: "Sign In", onPressed: validate),
                const SizedBox(height: 28),
                const OrDivider(),
                const SizedBox(height: 24),
                AuthSwitchText(
                  question: "Don't have an account? ",
                  actionText: "Sign Up",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
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
