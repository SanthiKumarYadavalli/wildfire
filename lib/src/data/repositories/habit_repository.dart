import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/data/services/habit_service.dart';

class HabitRepository {
  final HabitService _habitService = HabitService();

  Future<List<Habit>> getHabits(String userId) async {
    return await _habitService.getHabits(userId);
  }

  Future<Habit> createHabit(String token, Map<String, dynamic> data) async {
    return await _habitService.createHabit(token, data);
  }
}