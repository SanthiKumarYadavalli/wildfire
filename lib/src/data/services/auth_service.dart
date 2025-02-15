import 'dart:convert';
import 'package:http/http.dart';
import 'package:wildfire/src/app/config/env.dart';

class AuthService {
  Future<Map<String, dynamic>> loginUser(String username, String password) async {
    final response = await post(
      Uri.parse("${Env.apiUrl}/user/login"),
      body: {
        (username.contains('@') ? 'email': 'username') : username,
        'password': password,
      }
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to login");
    }
  }
}