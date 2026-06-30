class Balance {
  final double amount;
  final String currency;

  Balance({
    required this.amount,
    required this.currency,
  });

  factory Balance.fromJson(Map<String,dynamic> json){
    return Balance(
      amount: (json['balance'] as num).toDouble(),
      currency: json['currency'] ?? "XOF",
    );
  }
}