import 'package:flutter/material.dart';

import '../../../model/balance.dart';
import '../data/dashboard_service.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardService service = DashboardService();
  bool loading = false;
  Balance? balance;
  String? error;

  Future<void> loadBalance(String phone) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      balance =
          await service.getBalance(phone);
    }catch(e){
      error = e.toString();
    }
    loading = false;
    notifyListeners();
  }
}