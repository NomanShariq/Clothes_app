import 'package:clothing_app/models/user_session.dart';
import 'package:clothing_app/widgets/monarq_loader.dart';
import 'package:flutter/material.dart';

/// Shown briefly on cold app start. Checks whether a session was
/// previously saved (SharedPreferences) and routes accordingly —
/// straight to Homepage if still logged in, otherwise to Login.
class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await UserSession.loadFromPrefs();
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      UserSession.isLoggedIn ? "/home" : "/login",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const MonarqLoader(message: "Loading..."),
    );
  }
}
