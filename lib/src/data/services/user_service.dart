import 'dart:convert';
import 'package:http/http.dart';
import 'package:wildfire/src/app/config/env.dart';
class UserService {
  Future<Map<String, dynamic>> getUser(String id) async {
    final response = await get(Uri.parse("${Env.apiUrl}/user/$id"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to get user");
    }
  }
}