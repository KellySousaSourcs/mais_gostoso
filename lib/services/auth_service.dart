import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'http://SEU_IP:5000/api/auth';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Método para login/cadastro
  static Future<Map<String, dynamic>> login(String nome, String telefone) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nome': nome, 'telefone': telefone}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          // Salva os dados do usuário localmente
          await _storage.write(key: 'user_id', value: data['user']['id']);
          await _storage.write(key: 'user_nome', value: data['user']['nome']);
          await _storage.write(key: 'user_telefone', value: data['user']['telefone']);
          return {'success': true, 'user': data['user']};
        }
      }
      return {'success': false, 'message': 'Erro no login'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Verifica se há uma sessão ativa
  static Future<Map<String, dynamic>> checkSession() async {
    try {
      final telefone = await _storage.read(key: 'user_telefone');
      if (telefone == null) return {'success': false};

      final response = await http.get(
        Uri.parse('$_baseUrl/session/$telefone'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return {'success': true, 'user': data['user']};
        }
      }
      return {'success': false};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Logout
  static Future<void> logout() async {
    await _storage.deleteAll();
  }
}
