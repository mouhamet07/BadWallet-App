class Wallet {
  final int id;
  final String phoneNumber;
  final String email;
  final double balance;
  final String code;
  final String currency;

  Wallet({
    required this.id,
    required this.phoneNumber,
    required this.email,
    required this.balance,
    required this.code,
    required this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return Wallet(
      id: data['id'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      balance: (data['balance'] as num).toDouble(),
      code: data['code'],
      currency: data['currency'],
    );
  }
}