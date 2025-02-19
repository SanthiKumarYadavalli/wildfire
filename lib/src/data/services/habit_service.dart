
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
}