import 'dart:convert';
import 'package:http/http.dart';
import 'package:wildfire/src/app/config/env.dart';

class HabitService {
  Future<List<dynamic>> getHabits(userId) async {
    final response = await get(Uri.parse("${Env.apiUrl}/user/$userId/habits/"), );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List;
    } else {
      throw Exception("Failed to get habits");
    }
  }

  Future<Map<String, dynamic>> createHabit(token, data) async {
    final response = await post(
      Uri.parse("${Env.apiUrl}/habit/create/"),
      body: data,
      headers: {
        "Authorization": "Bearer $token",
      }
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to create habit");
    }
  }

  Future<void> toggleCompletion(token, habitId, date) async {
    final response = await post(
      Uri.parse("${Env.apiUrl}/user-habit/toggle-complete"),
      body: {
        "habitId": habitId,
        "date": date,
      },
      headers: {
        "Authorization": "Bearer $token",
      }
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to toggle completion");
    }
  }

  Future<Map<String, dynamic>> updateHabit(habitId, data) async {
    final response = await put(
      Uri.parse("${Env.apiUrl}/habit/$habitId/"),
      body: data,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to update habit");
    }
  }

  Future<void> deleteHabit(token, habitId) async {
    final response = await delete(
      Uri.parse("${Env.apiUrl}/habit/$habitId/"),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to delete habit");
    }
  }

  Future<void> unlinkFriend(userId, habitId) async {
    final response = await delete(
      Uri.parse("${Env.apiUrl}/user-habit/unlink/"),
      body: {
        "userId": userId,
        "habitId": habitId
      }
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to leave");
    }
  }

  Future<List<dynamic>> getFriends(habitId) async {
    final response = await get(Uri.parse("${Env.apiUrl}/user-habit/$habitId/members/"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List;
    } else {
      throw Exception("Failed to get friends");
    }
  }

  Future<Map<String, dynamic>> getHabit(habitId) async {
    final response = await get(Uri.parse("${Env.apiUrl}/habit/$habitId/"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to get habit");
    }
  }

  Future<void> joinFriend(userId, habitId) async {
    final response = await post(
      Uri.parse("${Env.apiUrl}/user-habit/link/"),
      body: {
        "userId": userId,
        "habitId": habitId
      }
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to join");
    }
  }
}