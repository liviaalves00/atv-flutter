import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  String? _email;
  String? _password;

  void login(String email, String password) {
    _email = email;
    _password = password;
    notifyListeners();
  }

  void register(String email, String password) {
    _email = email;
    _password = password;
    notifyListeners();
  }
}
