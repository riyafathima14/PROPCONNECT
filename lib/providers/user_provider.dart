import 'package:flutter/material.dart';
import 'package:propconnect/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userId;
  String? _username;
  String? _email;
  String? _phone;
  
  // Getters for basic info
  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;
  String? get username => _username;
  String? get email => _email;
  String? get phone => _phone;
  
  // Add a getter to generate a User model.
  // (This example assumes that missing first & last names are not needed.
  // If you have these values, you should update the provider and store them as well.)
  User? get user {
    if (_userId == null || _username == null) return null;
    return User(
      id: int.tryParse(_userId!) ?? 0,
      firstName: "",       // You can add firstName if you store it.
      lastName: "",        // You can add lastName if you store it.
      email: _email ?? "",
      phone: _phone ?? "",
      userName: _username!,
    );
  }
  
  // Load data from SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userId = prefs.getString('userId');
    _username = prefs.getString('username');
    _email = prefs.getString('email');
    _phone = prefs.getString('phone');
    notifyListeners();
  }
  
  // Update the user data (you might want to include first/last names if needed)
  Future<void> updateUserData({
    required String userId,
    required String username,
    String? email,
    String? phone,
  }) async {
    _isLoggedIn = true;
    _userId = userId;
    _username = username;
    _email = email;
    _phone = phone;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userId', userId);
    await prefs.setString('username', username);
    if (email != null) await prefs.setString('email', email);
    if (phone != null) await prefs.setString('phone', phone);
    
    notifyListeners();
  }
  
  Future<void> logout() async {
    _isLoggedIn = false;
    _userId = null;
    _username = null;
    _email = null;
    _phone = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
