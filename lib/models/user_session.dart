import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static String email = "";
  static String username = "";
  static String? token;

  static bool get isLoggedIn => token != null && token!.isNotEmpty;

  static const _keyEmail = "session_email";
  static const _keyUsername = "session_username";
  static const _keyToken = "session_token";

  /// Call this right after a successful login/registration.
  static Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyUsername, username);
    if (token != null) {
      await prefs.setString(_keyToken, token!);
    }
  }

  /// Call this once at app startup to restore a previous session.
  static Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString(_keyEmail) ?? "";
    username = prefs.getString(_keyUsername) ?? "";
    token = prefs.getString(_keyToken);
  }

  /// Call this on logout.
  static Future<void> clear() async {
    email = "";
    username = "";
    token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyToken);
  }
}
