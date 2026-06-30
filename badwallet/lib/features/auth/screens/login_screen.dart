import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../../dashboard/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (!formKey.currentState!.validate()) return;
    final phone = phoneController.text.trim();
    // Simulation authentification
    await Future.delayed(
      const Duration(milliseconds: 800),
    );
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardScreen(
          phone: phone,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 140,
                    height: 140,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Bienvenue",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Entrez votre numéro de téléphone",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Téléphone",
                      hintText: "+221770000000",
                      prefixIcon:
                          const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value){
                      if(value == null ||
                          value.isEmpty){
                        return "Numéro obligatoire";
                      }
                      if(!value.startsWith("+221")){
                        return "Numéro sénégalais invalide";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text(
                          "Continuer",
                          style:
                          TextStyle(fontSize: 18),
                        ),
                    ),
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }


  @override
  void dispose(){
    phoneController.dispose();
    super.dispose();
  }
}