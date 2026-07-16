import 'package:flutter/material.dart';
import '../database/hive/hive_helper.dart';
import '../models/user_model.dart';
import '../utils/pref_utils.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _authenticated = false;

  User? get user => _currentUser;
  bool get isLoggedIn => _authenticated;

  AuthProvider() {
    _init();
  }

  void _init() {
    _authenticated = PrefUtils.isLoggedIn();
    if (_authenticated) {
      _currentUser = HiveHelper.getUser();
    }
    notifyListeners();
  }

  Future<bool> login(String email, String pass) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email.isNotEmpty && pass.length >= 6) {
      final u = User(
        id: 'u_001',
        name: email.split('@')[0],
        email: email,
      );

      await HiveHelper.saveUser(u);
      await PrefUtils.setLoggedIn(true);
      
      _currentUser = u;
      _authenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String pass) async {
    await Future.delayed(const Duration(seconds: 2));

    if (name.isNotEmpty && email.contains('@') && pass.length >= 6) {
      final u = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
      );

      await HiveHelper.saveUser(u);
      await PrefUtils.setLoggedIn(true);
      
      _currentUser = u;
      _authenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await HiveHelper.clearUser();
    await PrefUtils.setLoggedIn(false);
    _currentUser = null;
    _authenticated = false;
    notifyListeners();
  }

  Future<void> updateProfile(User data) async {
    await HiveHelper.saveUser(data);
    _currentUser = data;
    notifyListeners();
  }
}
