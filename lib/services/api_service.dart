import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // Fungsi login
  static Future<bool> login(String username, String password) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/login');

    final response = await http.post(
      url,
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Login berhasil: $data');
      return true;
    } else {
      print('Login gagal: ${response.body}');
      return false;
    }
  }

  // Fungsi register sesuai API Laravel
  static Future<bool> register(
    String name,
    String username,
    String email,
    String password,
  ) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/register');

    final response = await http.post(
      url,
      body: {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Registrasi berhasil: $data');
      return true;
    } else {
      print('Registrasi gagal: ${response.body}');
      return false;
    }
  }
}
