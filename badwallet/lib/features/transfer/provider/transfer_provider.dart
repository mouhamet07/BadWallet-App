import 'package:flutter/material.dart';

import '../../../model/transfer_request.dart';
import '../data/transfer_service.dart';

class TransferProvider extends ChangeNotifier {
  final TransferService service = TransferService();
  bool loading=false;
  String? error;
  Future<bool> sendMoney(TransferRequest request) async {
    loading=true;
    error=null;
    notifyListeners();
    try{
      await service.transfer(request);
      loading=false;
      notifyListeners();
      return true;
    }catch(e){
      error=e.toString();
      loading=false;
      notifyListeners();
      return false;
    }
  }
}