import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  // Substitua pelo IP da sua máquina (não use localhost)
  static const String _baseUrl = "http://172.30.247.10:8000/api";
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static bool isLoggedIn = false;

  static Future<Map<String, dynamic>> login(
    String nome,
    String telefone,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'nome': nome, 'telefone': telefone}),
      );

      final data = json.decode(
        utf8.decode(response.bodyBytes),
      ); // Corrige encoding

      switch (response.statusCode) {
        case 200:
          if (data['token'] != null) {
            await _storage.write(key: 'token', value: data['token']);
            isLoggedIn = true;
            return {
              'success': true,
              'token': data['token'],
              'user': data['user'] ?? {},
            };
          }
          return {'success': false, 'message': 'Token não recebido'};
        case 401:
          return {'success': false, 'message': 'Credenciais inválidas'};
        default:
          return {
            'success': false,
            'message': data['message'] ?? 'Erro desconhecido',
          };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro de conexão: $e',
        'details': 'Verifique se o servidor está rodando e o IP está correto',
      };
    }
  }

  static Future<Map<String, dynamic>> checkSession() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token == null || token.isEmpty) {
        return {'success': false, 'message': 'Nenhum token encontrado'};
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/check-session'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final data = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        isLoggedIn = true;
        return {'success': true, 'user': data['user'] ?? {}};
      } else {
        await _storage.delete(key: 'token');
        isLoggedIn = false;
        return {
          'success': false,
          'message': data['message'] ?? 'Sessão expirada',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Erro ao verificar sessão: $e'};
    }
  }

  static Future<void> logout() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token != null) {
        await http.post(
          Uri.parse('$_baseUrl/logout'),
          headers: {'Authorization': 'Bearer $token'},
        );
      }
    } finally {
      await _storage.delete(key: 'token');
      isLoggedIn = false;
    }
  }

  static Future<void> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse('http://172.30.247.10:8000/api/test'),
        headers: {'Content-Type': 'application/json'},
      );
      print('Resposta do servidor: ${response.statusCode} - ${response.body}');
    } catch (e) {
      print('Erro detalhado: $e');
    }
  }
}
