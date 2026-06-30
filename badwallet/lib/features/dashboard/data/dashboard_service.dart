import '../../../core/services/api_services.dart';
import '../../../model/balance.dart';

class DashboardService {
  final ApiService api = ApiService();

  Future<Balance> getBalance(String phone) async {
    final response = await api.dio.get(
      "/api/wallets/$phone/balance",
    );
    return Balance.fromJson(response.data);
  }
}