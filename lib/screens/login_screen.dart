import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
const LoginScreen({Key? key}) : super(key: key);

@override
State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final _formKey = GlobalKey<FormState>();
final _nomeController = TextEditingController();
final _telefoneController = TextEditingController();
bool _isLoading = false;

@override
void dispose() {
_nomeController.dispose();
_telefoneController.dispose();
super.dispose();
}

Future<void> _login() async {
if (!_formKey.currentState!.validate()) {
return;
}


setState(() {
  _isLoading = true;
});

try {
  // Salvar dados do usuário no SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_name', _nomeController.text.trim());
  await prefs.setString('user_phone', _telefoneController.text.trim());
  await prefs.setBool('is_logged_in', true);

  // Navegar para a tela home
  if (mounted) {
    Navigator.pushReplacementNamed(context, '/home');
  }
} catch (e) {
  // Mostrar erro se houver
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro ao fazer login: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
} finally {
  if (mounted) {
    setState(() {
      _isLoading = false;
    });
  }
}


}

String? _validateNome(String? value) {
if (value == null || value.trim().isEmpty) {
return 'Nome é obrigatório';
}
return null;
}

String? _validateTelefone(String? value) {
if (value == null || value.trim().isEmpty) {
return 'Telefone é obrigatório';
}



// Remove caracteres não numéricos
String numericOnly = value.replaceAll(RegExp(r'[^0-9]'), '');

if (numericOnly.length != 11) {
  return 'Telefone deve ter 11 dígitos';
}

return null;

}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFEDDD1D), // Fundo amarelo
body: SafeArea(
child: SingleChildScrollView(
child: SizedBox(
height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
child: Column(
children: [
// Seção superior com ícone da chef
Expanded(
flex: 2,
child: Container(
width: double.infinity,
color: const Color(0xFFEDDD1D),
child: const Center(
child: CircleAvatar(
radius: 60,
backgroundColor: Colors.white,
child: Icon(
Icons.person_outline,
size: 80,
color: Color(0xFF2D5016),
),
),
),
),
),

            // Container principal com formulário
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF4EEE1), // Bege claro
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  border: Border(
                    top: BorderSide(color: Colors.black26, width: 1),
                    left: BorderSide(color: Colors.black26, width: 1),
                    right: BorderSide(color: Colors.black26, width: 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),

                        // Campo Nome
                        const Text(
                          'NOME:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nomeController,
                          validator: _validateNome,
                          decoration: InputDecoration(
                            hintText: 'Digite seu nome',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black26),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF2D5016), width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Campo Telefone
                        const Text(
                          'TELEFONE:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _telefoneController,
                          validator: _validateTelefone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: '(11) 99999-9999',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black26),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF2D5016), width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Botão Entrar
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2D5016), // Verde escuro
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  )
                                : const Text(
                                    'ENTRAR',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Texto "ou"
                        const Center(
                          child: Text(
                            'ou',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Botão Google
                        SizedBox(
                          height: 56,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Por enquanto apenas mostra uma mensagem
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login com Google em desenvolvimento'),
                                  backgroundColor: Color(0xFFEDDD1D),
                                ),
                              );
                            },
                            icon: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  'G',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4285F4),
                                  ),
                                ),
                              ),
                            ),
                            label: const Text(
                              'Entrar com Google',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFEDDD1D), // Amarelo
                              side: const BorderSide(color: Colors.black26),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Logo +GOSTOSO
                        const Center(
                          child: Text(
                            '+GOSTOSO',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D5016),
                              letterSpacing: 2,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);


}
}

// Middleware para verificar login antes de acessar outras rotas
class AuthGuard {
static Future<bool> isLoggedIn() async {
final prefs = await SharedPreferences.getInstance();
return prefs.getBool('is_logged_in') ?? false;
}

static Future<void> checkAuthAndNavigate(BuildContext context, String route) async {
final isLoggedIn = await AuthGuard.isLoggedIn();
if (!isLoggedIn) {
Navigator.pushReplacementNamed(context, '/login');
} else {
Navigator.pushNamed(context, route);
}
}

static Future<Map<String, String?>> getUserData() async {
final prefs = await SharedPreferences.getInstance();
return {
'name': prefs.getString('user_name'),
'phone': prefs.getString('user_phone'),
};
}

static Future<void> logout() async {
final prefs = await SharedPreferences.getInstance();
await prefs.clear();
}
}