import 'package:dio/dio.dart';

import '../../../core/services/api_services.dart';
import '../../../model/wallet.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<Wallet> login(String phone) async {
    try {
      final Response response =
          await _apiService.dio.get("/api/wallets/$phone");
          print("STATUS : ${response.statusCode}");
        print("DATA : ${response.data}");
      return Wallet.fromJson(response.data);
    } on DioException catch (e) {
      print("DIO ERROR : ${e.message}");
    print("RESPONSE : ${e.response?.data}");

    throw Exception(
      "Erreur API : ${e.message}"
    );
    }
  }
}