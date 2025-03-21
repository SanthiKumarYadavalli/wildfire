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

  Future<Map<String, dynamic>> updateUser(String id, Map<String, dynamic> data) async {
    var request = MultipartRequest("PUT", Uri.parse("${Env.apiUrl}/user/$id/"));
    if (data.containsKey("image")) {
      request.files.add(await MultipartFile.fromPath("image", data["image"].path));
    }
    if (data.containsKey("name")) {
      request.fields["name"] = data["name"];
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString()) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to update user");
    }
  }
}