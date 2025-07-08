import 'dart:convert';
import 'package:forumapp/screens/models/book_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.3:8000/api';

  // ================================
  // AUTH
  // ================================

  static Future<bool> register(
    String name,
    String username,
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    print('>>> [REGISTER] Status Code: ${response.statusCode}');
    print('>>> [REGISTER] Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setInt('user_id', data['user']['id']);
      return true;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {'username': username, 'password': password},
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200 && data['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setInt('user_id', data['user']['id']);
      return {'success': true, 'user': data['user']};
    } else {
      return {'success': false, 'error': data['message'] ?? 'Login gagal'};
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_id');
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // ================================
  // BUKU
  // ================================

  static Future<List<BookModel>> fetchBukuTerbaru() async {
    final token = await getToken();
    final url = Uri.parse('$baseUrl/buku-terbaru');

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final List data = res['data'];
      return data.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat buku terbaru');
    }
  }


  // ================================
  // KATEGORI BUKU
  // ================================

static Future<List<Map<String, dynamic>>> fetchKategoriBuku() async {
  final token = await getToken();
  final url = Uri.parse('$baseUrl/kategori'); // ✅ GANTI DENGAN ENDPOINT YANG BENAR

  final response = await http.get(
    url,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    
    // Ambil list dari key 'data'
    final List kategori = jsonData['data'];

    return kategori.map<Map<String, dynamic>>((item) {
      return {
        'id': item['id'],
        'nama': item['name'] ?? 'Tanpa Nama',
      };
    }).toList();
  } else {
    print('STATUS KATEGORI: ${response.statusCode}');
    print('BODY KATEGORI: ${response.body}');
    throw Exception('Gagal memuat kategori buku');
  }
}


  static Future<List<BookModel>> fetchBukuByKategori(int kategoriId) async {
    final token = await getToken();
    final url = Uri.parse('$baseUrl/BukuKategori/$kategoriId');

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data']['data']; // untuk pagination
      return data.map((item) => BookModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat buku berdasarkan kategori');
    }
  }



  // ================================
  // PEMINJAMAN
  // ================================

  static Future<Map<String, dynamic>> borrowBook({
    required int bukuId,
    required int userId,
    required String tenggatWaktu,
  }) async {
    final token = await getToken();
    if (token == null) {
      return {'success': false, 'error': 'Token tidak ditemukan. Login dulu.'};
    }

    final url = Uri.parse('$baseUrl/pinjamBuku');

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
}
