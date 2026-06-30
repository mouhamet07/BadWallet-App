class Facture {
  final String reference;
  final String serviceName;
  final double amount;
  bool selected;

  Facture({
    required this.reference,
    required this.serviceName,
    required this.amount,
    this.selected = false,
  });
  factory Facture.fromJson(Map<String,dynamic> json){
    return Facture(
      reference: json['reference'],
      serviceName: json['serviceName'],
      amount:
      (json['amount'] as num).toDouble(),
    );
  }
}
