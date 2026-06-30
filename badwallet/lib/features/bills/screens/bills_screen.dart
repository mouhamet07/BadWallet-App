import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/bills_provider.dart';

class BillsScreen extends StatefulWidget {
  final String phone;
  final String walletCode;
  const BillsScreen({
    super.key,
    required this.phone,
    required this.walletCode,
  });
  @override
  State<BillsScreen> createState() => _BillsScreenState();
}
class _BillsScreenState extends State<BillsScreen>{
  @override
  void initState(){
    super.initState();
    Future.microtask((){
    context
      .read<BillsProvider>()
      .loadFactures(
        widget.walletCode
      );
    });
  }
  @override
  Widget build(BuildContext context){
    final provider = context.watch<BillsProvider>();
    return Scaffold(
      appBar:AppBar(
        title:const Text("Paiement factures"),
      ),
    body:provider.loading ?
      const Center(
        child:CircularProgressIndicator(),
      ) :
      Column(
        children:[
          Expanded(
            child:ListView.builder(
              itemCount:provider.factures.length,
              itemBuilder:(context,index){
                final facture =provider.factures[index];
                return CheckboxListTile(
                  value:facture.selected,
                  onChanged:(v){
                    provider.toggleFacture(index);
                  },
                  title:
                    Text(
                    facture.serviceName,
                    ),
                    subtitle:
                    Text(
                    "${facture.amount} XOF",
                    ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed:() async{
              final ok = await provider.pay(
                phone: widget.phone,
                serviceName:"ISM",
              );
              if(ok && mounted){
                ScaffoldMessenger.of(context)
                  .showSnackBar(
                    const SnackBar(
                      content:
                        Text(
                          "Factures payées"
                        ),
                    ),
                  );
              }
            },
            child:
              const Text(
                "Payer"
              ),
          )
        ],
      ),
    );
  }
}