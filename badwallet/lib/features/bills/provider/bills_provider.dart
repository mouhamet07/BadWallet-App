import 'package:flutter/material.dart';

import '../../../model/facture.dart';
import '../data/bills_service.dart';

class BillsProvider extends ChangeNotifier {
  final BillsService service = BillsService();
  bool loading=false;
  List<Facture> factures=[];
  Future<void> loadFactures(String walletCode) async {
    loading=true;
    notifyListeners();
    factures =await service.getFactures(walletCode);
    loading=false;
    notifyListeners();
  }
  void toggleFacture(int index){
    factures[index].selected =
    !factures[index].selected;
    notifyListeners();
  }
  Future<bool> pay({
  required String phone,
  required String serviceName,
  }) async {
    final selected =
    factures
      .where((f)=>f.selected)
      .map((f)=>f.reference)
      .toList();
    if(selected.isEmpty){
      return false;
    }
    await service.payFactures(
      phone: phone,
      serviceName: serviceName,
      references: selected,
      );
    return true;
  }
}