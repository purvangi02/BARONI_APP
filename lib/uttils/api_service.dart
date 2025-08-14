import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ApiService {
  static const String baseUrl = 'https://baroni-be.onrender.com/api';

  static Future<Map<String, dynamic>?> login(String contact, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'contact': contact, 'password': password}),
    );
    log(contact);
    log(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> register({
    required String contact,
    required String password,
    String? email,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final body = {
      'contact': contact,
      'password': password,
    };
    if (email != null && email.isNotEmpty) {
      body['email'] = email;
    }
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    log(contact);
    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> verifyOtp({
    required String userId,
    required String otp,
    required String accessToken,
  }) async {
    final url = Uri.parse('$baseUrl/auth/verify-otp');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({'userId': userId, 'otp': otp}),
    );
    log(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> completeProfile({
    required String name,
    required String pseudo,
    File? profilePic,
    required String preferredLanguage,
    required String country,
    required String email,
    required String contact,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken') ?? '';
    final url = Uri.parse('$baseUrl/auth/complete-profile');
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $accessToken';

    request.fields['name'] = name;
    request.fields['pseudo'] = pseudo;
    request.fields['preferredLanguage'] = preferredLanguage;
    request.fields['country'] = country;
    request.fields['email'] = email;
    request.fields['contact'] = contact;

    if (profilePic != null) {
      request.files.add(await http.MultipartFile.fromPath('profilePic', profilePic.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    log(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    }
    return null;
  }
}
