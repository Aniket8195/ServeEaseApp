import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo{

  static const String _roleKey = 'role';
  static const String _idKey = 'id';
  static const String _tokenKey = 'token';

  // Check if the user is logged in by checking if the token exists
  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  // Get user role
  Future<String> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString(_roleKey);
    return role ?? 'seeker'; // Default role is 'seeker' if not found
  }

  // Get user ID
  Future<int> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt(_idKey);
    return id ?? 0; // Default ID is 0 if not found
  }

  // Get user JWT token
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    return token ?? 'token'; // Default token if not found
  }

  // Save user data (role, id, token)
  Future<void> saveUserData(String role, int id, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
    await prefs.setInt(_idKey, id);
    await prefs.setString(_tokenKey, token);
  }

  // Clear user data (log out)
  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
    await prefs.remove(_idKey);
    await prefs.remove(_tokenKey);
  }

}