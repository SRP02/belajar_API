import 'package:belajar_api/model/Auth_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String baseUrl = 'https://mediadwi.com/api/latihan';

  Future<ApiResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    final jsonResponse = json.decode(response.body);
    return ApiResponse.fromJson(jsonResponse);
  }

  Future<ApiResponse> register(
    String username,
    String password,
    String fullName,
    String email,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register-user'),
      body: {
        'username': username,
        'password': password,
        'full_name': fullName,
        'email': email,
      },
    );

    final jsonResponse = json.decode(response.body);
    return ApiResponse.fromJson(jsonResponse);
  }
}
