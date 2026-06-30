import '../../../core/services/api_services.dart';
import '../../../model/facture.dart';

class BillsService {
  final ApiService api = ApiService();
  Future<List<Facture>> getFactures(String walletCode) async {
    final response =
    await api.dio.get("/api/external/factures/$walletCode/current",);
    final data = response.data['data'];
    return (data as List).map((e)=>Facture.fromJson(e)).toList();
  }
  Future<void> payFactures({
  required String phone,
  required String serviceName,
  required List<String> references,
  }) async {
    await api.dio.post(
      "/api/wallets/pay-factures",
      data: {
      "phoneNumber": phone,
      "serviceName": serviceName,
      "factureReferences": references
      }
    );
  }
}