class TransferRequest {

  final String senderPhone;
  final String receiverPhone;
  final double amount;

  TransferRequest({
    required this.senderPhone,
    required this.receiverPhone,
    required this.amount,
  });
  
  Map<String,dynamic> toJson(){
    return {
      "senderPhone": senderPhone,
      "receiverPhone": receiverPhone,
      "amount": amount,
    };
  }
}