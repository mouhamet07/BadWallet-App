import 'package:flutter/material.dart';

import '../../features/transfer/screens/transfer_screen.dart';
import '../../features/bills/screens/bills_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.phone,
  });
  final String phone;
  final List<MenuItem> menuItems = const [
    MenuItem(
      title: 'Accueil',
      icon: Icons.home,
      type: MenuType.home,
    ),
    MenuItem(
      title: 'Transférer',
      icon: Icons.send,
      type: MenuType.transfer,
    ),
    MenuItem(
      title: 'Payer',
      icon: Icons.payment,
      type: MenuType.payment,
    ),
    MenuItem(
      title: 'Historique',
      icon: Icons.history,
      type: MenuType.history,
    ),
    MenuItem(
      title: 'Déconnexion',
      icon: Icons.logout,
      type: MenuType.logout,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 55,
                ),
                const SizedBox(height:10),
                const Text(
                  "BadWallet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:22,
                    fontWeight:FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          for(final item in menuItems)
            DrawerMenuItem(
              item:item,
              phone:phone,
            )
        ],
      ),
    );
  }
}


class DrawerMenuItem extends StatelessWidget {
  final MenuItem item;
  final String phone;
  const DrawerMenuItem({
    super.key,
    required this.item,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            item.icon,
            color: Colors.blue,
          ),
          title: Text(
            item.title,
            style: const TextStyle(
              fontSize:18,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            switch(item.type){
              case MenuType.transfer:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                      TransferScreen(
                        senderPhone: phone,
                      ),
                  ),
                );
                break;
              case MenuType.home:
                break;
              case MenuType.payment:
                Navigator.push(
                context,
                MaterialPageRoute(
                builder:(_)=>
                BillsScreen(
                phone:phone,
                walletCode:"WLT-4",
                ),
                ),
                );
                break;
              case MenuType.history:
                // TODO HistoryScreen
                break;
              case MenuType.logout:
                // TODO logout
                break;
            }
          },
        ),
        const Divider(),
      ],
    );
  }
}

enum MenuType {
  home,
  transfer,
  payment,
  history,
  logout,
}
class MenuItem {
 final String title;
 final IconData icon;
 final MenuType type;
 const MenuItem({
  required this.title,
  required this.icon,
  required this.type,
 });
}