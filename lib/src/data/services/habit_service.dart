import 'dart:convert';
import 'package:http/http.dart';
import 'package:wildfire/src/app/config/env.dart';
import 'package:wildfire/src/data/models/habit_model.dart';

class HabitService {
  Future<List<Habit>> getHabits(userId) async {
    final response = await get(Uri.parse("${Env.apiUrl}/user/$userId/habits/"), );
    if (response.statusCode == 200) {
      final habitsData = jsonDecode(response.body) as List;
      return habitsData.map((habit) {
        return Habit(
          id: habit['habit']['_id'],
          title: habit['habit']['title'],
          description: habit['habit']['description'],
          createdBy: habit['habit']['createdBy'],
        );
      }).toList();
    } else {
      throw Exception("Failed to get habits");
    }
  }

  Future<Habit> createHabit(token, data) async {
    final response = await post(
      Uri.parse("${Env.apiUrl}/habit/create/"),
      body: data,
      headers: {
        "Authorization": "Bearer $token",
      }
    );
    if (response.statusCode == 201) {
      final habitData = jsonDecode(response.body) as Map<String, dynamic>;
      return Habit(
        id: habitData['_id'],
        title: habitData['title'],
        description: habitData['description'],
        createdBy: habitData['createdBy'],
      );
    } else {
      throw Exception("Failed to create habit");
    }
  }
}