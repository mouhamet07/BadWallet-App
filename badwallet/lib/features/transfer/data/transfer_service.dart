import '../../../core/services/api_services.dart';
import '../../../model/transfer_request.dart';

class TransferService {
  final ApiService api = ApiService();
  Future<void> transfer( TransferRequest request) async {
    await api.dio.post(
      "/api/wallets/transfer",
      data: request.toJson(),
    );
  }
}