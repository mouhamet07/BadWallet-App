import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dashboard_provider.dart';
import '../../transfer/screens/transfer_screen.dart';
import '../../../core/widgets/drawer_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key,required this.phone});

  final String phone;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen>{
  bool hideBalance=false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
        .read<DashboardProvider>()
        .loadBalance(widget.phone);
    });
  }

  @override
  Widget build(BuildContext context){
    final provider =
    context.watch<DashboardProvider>();
    return Scaffold(
      drawer: DrawerWidget(
        phone: widget.phone,
      ),
      appBar: AppBar(
        title: const Text("BadWallet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const Text(
              "Votre solde",
              style: TextStyle(
                fontSize:18,
              ),
            ),
            const SizedBox(height:10),
            Container(
              width:double.infinity,
              padding:const EdgeInsets.all(25),
              decoration:BoxDecoration(
                color: Colors.blue,
                borderRadius:BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                  Text(
                    provider.loading ? "Chargement..."
                    : hideBalance
                    ? "*****"
                    : "${provider.balance?.amount ?? 190000} ${provider.balance?.currency ?? ''}",
                    style:const TextStyle(
                      fontSize:30,
                      color:Colors.white,
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed:(){
                      setState(() { 
                        hideBalance = !hideBalance;
                      });
                    },
                    icon:Icon(
                      hideBalance
                      ? Icons.visibility_off
                      : Icons.visibility,
                      color:Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height:30),
            const Text(
              "Dernières transactions",
              style:TextStyle(
                fontSize:20,
                fontWeight:FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:5,
                itemBuilder:(context,index){
                  return ListTile(
                    leading:const CircleAvatar(
                      child:Icon(Icons.money),
                    ),
                    title:Text(
                      "Transaction ${index+1}",
                    ),
                    subtitle:const Text(
                      "Aujourd'hui",
                    ),
                    trailing: Text(
                      "-2000 XOF",
                      style:TextStyle(
                        color:Colors.red,
                      ),
                    ),
                  );
                },
              ),
            )
          ],  
        ),
      ),
    );
  }
}