import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userId;
  String? _userName;
  String? _userEmail;
  bool _isLoading = false;

  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _userId != null;

  void setUser(String id, String name, String email) {
    _userId = id;
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearUser() {
    _userId = null;
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }
}
