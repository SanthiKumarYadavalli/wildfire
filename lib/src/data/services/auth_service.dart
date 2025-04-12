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

  Future<void> signupUser(String name, String username, String email, String password) async {
    final response = await post(
      Uri.parse("${Env.apiUrl}/user/register"),
      body: {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      }
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to signup");
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final response = await post(
      Uri.parse("${Env.apiUrl}/user/forgot-password"),
      body: {
        'email': email,
      }
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to send password reset email");
    }
  }

  Future<void> resetPassword(String token, String password) async {
    final response = await post(
      Uri.parse("${Env.apiUrl}/user/reset-password/$token"),
      body: {
        'newPassword': password,
      }
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to reset password");
    }
  }

  Future<void> verifyToken(String token) async {
    final response = await get(
      Uri.parse("${Env.apiUrl}/user/verify-token/"),
      headers: {
        "Authorization": "Bearer $token"
      }
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to verify token");
    }
  }
}