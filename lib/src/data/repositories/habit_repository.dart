import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/data/services/habit_service.dart';

class HabitRepository {
  final HabitService _habitService = HabitService();

  Future<List<Habit>> getHabits(String userId) async {
    final habitsData = await _habitService.getHabits(userId);
    return habitsData.map((habit) {
      return Habit(
        id: habit['habit']['_id'],
        title: habit['habit']['title'],
        description: habit['habit']['description'],
        createdBy: habit['habit']['createdBy'],
        dates: habit['dates'],
      );
    }).toList();
  }

  Future<Habit> createHabit(String token, Map<String, dynamic> data) async {
    final habitData = await _habitService.createHabit(token, data);
    return Habit(
      id: habitData['_id'],
      title: habitData['title'],
      description: habitData['description'],
      createdBy: habitData['createdBy'],
    );
  }

  Future<void> toggleCompletion(String token, String habitId, String date) async {
    await _habitService.toggleCompletion(token, habitId, date);
  }
}