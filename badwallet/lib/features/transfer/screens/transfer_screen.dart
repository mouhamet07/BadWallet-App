import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/transfer_request.dart';
import '../provider/transfer_provider.dart';

class TransferScreen extends StatefulWidget {
  final String senderPhone;
  const TransferScreen({super.key, required this.senderPhone});
  @override
  State<TransferScreen> createState() => _TransferScreenState();
}
class _TransferScreenState extends State<TransferScreen>{
  final receiverController =TextEditingController();
  final amountController =TextEditingController();
  void send(){
    final request = TransferRequest(
      senderPhone:widget.senderPhone,
      receiverPhone:receiverController.text,
      amount:double.parse(
        amountController.text
      ),
    );
    context
    .read<TransferProvider>()
    .sendMoney(request)
    .then((success){
      if(!mounted)return;
      if(success){
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:Text(
              "Transfert effectué"
            ),
          )
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:Text(
              "Erreur transfert"
            ),
          )
        );
      }
    });
  }
  @override
  Widget build(BuildContext context){
    final provider =context.watch<TransferProvider>();
    return Scaffold(
      appBar:AppBar(
        title:const Text(
          "Transférer"
        ),
      ),
      body:Padding(
        padding:const EdgeInsets.all(20),
        child:Column(
          children:[
            TextField(
              controller:receiverController,
              keyboardType:TextInputType.phone,
              decoration:const InputDecoration(
                labelText:"Numéro destinataire",
                prefixIcon:Icon(Icons.phone),
              ),
            ),
            const SizedBox(height:20),
            TextField(
              controller:amountController,
              keyboardType:TextInputType.number,
              decoration:const InputDecoration(
                labelText:"Montant",
                suffixText:"XOF"
                ),
              ),
            const SizedBox(height:40),
              SizedBox(
                width:double.infinity,
                height:55,
                child:
                  ElevatedButton(
                    onPressed:provider.loading ? null : send,
                    child: provider.loading ? const CircularProgressIndicator() :
                      const Text(
                        "Envoyer"
                      ),
                  ),
              )
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
  receiverController.dispose();
  amountController.dispose();
  super.dispose();
  }
}