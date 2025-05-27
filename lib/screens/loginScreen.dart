import 'package:flutter/material.dart';
import 'package:mais_gostoso/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required bool returnToPrevious});

  @override
  Widget build(BuildContext context) {
    final nomeController = TextEditingController();
    final telefoneController = TextEditingController();
    bool isLoading = false; // Adicionado estado de loading

    // Verifica sessão ao iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final session = await AuthService.checkSession();
      if (session['success'] == true) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFEDDD1D),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Logo
            Center(
              child: Image.asset(
                'assets/images/facemaisGostoso.png',
                height: 150,
                width: 138,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4EEE1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: SingleChildScrollView(
                  // <-- Adicionado
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'NOME:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nomeController,
                        decoration: InputDecoration(
                          hintText: 'Digite seu nome aqui',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'TELEFONE:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: telefoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Digite seu número aqui',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (nomeController.text.isEmpty ||
                              telefoneController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Por favor, preencha todos os campos',
                                ),
                              ),
                            );
                            return;
                          }

                          final result = await AuthService.login(
                            nomeController.text.trim(),
                            telefoneController.text.trim(),
                          );

                          if (result['success'] == true) {
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  result['message'] ?? 'Erro no login',
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF252810),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'ENTRAR',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Image.asset(
                          'assets/images/hatchef.png',
                          height: 97,
                          width: 255,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
