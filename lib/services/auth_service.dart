import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'http://localhost:5000/api/auth';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Método para login/cadastro
  static Future<Map<String, dynamic>> login(String nome, String telefone) async {
    try {
      // Validação básica dos inputs
      if (nome.isEmpty || telefone.isEmpty) {
        return {
          'success': false,
          'message': 'Nome e telefone são obrigatórios'
        };
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': nome.trim(),
          'telefone': telefone.trim().replaceAll(RegExp(r'[^0-9]'), ''),
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          // Salva os dados do usuário localmente de forma segura
          await _saveUserData(data['user']);
          return {'success': true, 'user': data['user']};
        }
        return {
          'success': false,
          'message': data['message'] ?? 'Erro desconhecido no login'
        };
      } else {
        return {
          'success': false,
          'message': 'Erro de conexão (${response.statusCode})'
        };
      }
    } on http.ClientException catch (e) {
      return {'success': false, 'message': 'Erro de conexão: ${e.message}'};
    } on TimeoutException {
      return {'success': false, 'message': 'Tempo de conexão esgotado'};
    } catch (e) {
      return {'success': false, 'message': 'Erro inesperado: ${e.toString()}'};
    }
  }

  // Verifica se há uma sessão ativa
  static Future<Map<String, dynamic>> checkSession() async {
    try {
      final telefone = await _storage.read(key: 'user_telefone');
      if (telefone == null || telefone.isEmpty) {
        await _storage.deleteAll();
        return {'success': false};
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/session/$telefone'),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          // Atualiza os dados locais
          await _saveUserData(data['user']);
          return {'success': true, 'user': data['user']};
        }
      }
      
      // Se falhar, limpa o storage
      await _storage.deleteAll();
      return {'success': false};
    } on TimeoutException {
      return {'success': false, 'message': 'Verificação de sessão demorou muito'};
    } catch (e) {
      await _storage.deleteAll();
      return {'success': false};
    }
  }

  // Logout
  static Future<void> logout() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      // Ignora erros no logout
    }
  }

  // Método privado para salvar dados do usuário de forma consistente
  static Future<void> _saveUserData(Map<String, dynamic> user) async {
    try {
      await Future.wait([
        _storage.write(key: 'user_id', value: user['id']?.toString() ?? ''),
        _storage.write(key: 'user_nome', value: user['nome']?.toString() ?? ''),
        _storage.write(
            key: 'user_telefone', value: user['telefone']?.toString() ?? ''),
      ]);
    } catch (e) {
      // Se falhar ao salvar, limpa tudo para evitar inconsistências
      await _storage.deleteAll();
      throw Exception('Falha ao salvar dados do usuário');
    }
  }
}