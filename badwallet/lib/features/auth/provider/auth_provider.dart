import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../model/wallet.dart';
import '../data/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  final storage = FlutterSecureStorage();
  Wallet? wallet;
  String? error;
  Future<bool> login(String phone) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      wallet = await _authService.login(phone);
      await storage.write(
        key: "phone",
        value: phone,
      );
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}