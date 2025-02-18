import 'dart:convert';
import 'package:http/http.dart';
import 'package:wildfire/src/app/config/env.dart';
import 'package:wildfire/src/data/models/user_model.dart';

class UserService {
  Future<User> getUser(String id) async {
    final response = await get(Uri.parse("${Env.apiUrl}/user/$id"));
    if (response.statusCode == 200) {
      final userData =  jsonDecode(response.body) as Map<String, dynamic>;
      return User(
        id: userData['_id'],
        username: userData['username'],
        email: userData['email'],
        name: userData['name'],
        profileImageUrl: userData['profilePic'],
      );
    } else {
      throw Exception("Failed to get user");
    }
  }
}