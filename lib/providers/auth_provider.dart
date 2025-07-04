import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  bool get isAuthenticated => _token != null;

  Future<void> login(String username, String password) async {
    // Simulasi login
    if (username == 'admin' && password == 'admin123') {
      _token =
          'dummy_token_123'; // simpan token dari server (jika pakai backend)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      notifyListeners();
    } else {
      throw Exception('Username atau Password salah');
    }
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) return;

    _token = prefs.getString('token');
    notifyListeners();
  }
}
