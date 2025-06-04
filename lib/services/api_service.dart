import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

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
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        // <--- ubah ini jadi jsonEncode
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      }),
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

  // LOGIN: Mengambil token dari Laravel Sanctum
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/login');
    final response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {'username': username, 'password': password},
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200 && data['token'] != null) {
      // Simpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setInt('user_id', data['user']['id']); // Simpan juga user_id

      return {'success': true, 'user': data['user']};
    } else {
      return {'success': false, 'error': data['message'] ?? 'Login gagal'};
    }
  }

  // AMBIL TOKEN
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // AMBIL USER ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // PEMINJAMAN BUKU
  static Future<Map<String, dynamic>> borrowBook({
    required int bukuId,
    required int userId,
    required String tenggatWaktu,
  }) async {
    final token = await getToken();
    if (token == null) {
      return {'success': false, 'error': 'Token tidak ditemukan. Login dulu.'};
    }

    final url = Uri.parse('http://127.0.0.1:8000/api/pinjamBuku');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        'buku_id': bukuId,
        'user_id': userId,
        'tenggat_waktu': tenggatWaktu,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return {'success': true, 'data': data};
    } else {
      print('Peminjaman gagal: ${response.body}');
      return {'success': false, 'error': response.body};
    }
  }

  // LOGOUT (Opsional)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_id');
  }
}
