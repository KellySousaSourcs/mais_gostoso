import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mais_gostoso/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  // Alterado para StatefulWidget
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  bool isLoading = false;
  bool isCheckingSession =
      true; // Adicionado para controle de verificação inicial

  @override
  void initState() {
    super.initState();
    _checkInitialSession();
    // Teste de conexão (opcional - para debug)
    AuthService.testConnection();
  }

  Future<void> _checkInitialSession() async {
    try {
      final session = await AuthService.checkSession();
      if (session['success'] == true && mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } finally {
      if (mounted) {
        setState(() => isCheckingSession = false);
      }
    }
  }

  Future<void> _handleLogin() async {
    if (nomeController.text.isEmpty || telefoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await AuthService.login(
        nomeController.text.trim(),
        telefoneController.text.trim(),
      );

      if (!mounted) return;

      if (result['success'] == true) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Erro no login')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: ${e.toString()}')));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isCheckingSession) {
      return const Scaffold(
        backgroundColor: Color(0xFFEDDD1D),
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                decoration: const BoxDecoration(
                  color: Color(0xFFF4EEE1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
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
                        onPressed: isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF252810),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:
                            isLoading
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text(
                                  'ENTRAR',
                                  style: TextStyle(color: Color(0xFFF4FFF1)),
                                ),
                      ),
                      const SizedBox(height: 10),
                      const Spacer(),
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
