import 'package:wildfire/src/data/models/friend_model.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/data/models/user_model.dart';
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
        emoji: habit['habit']['emoji'] ?? "😢",
        dates: (habit['dates']).cast<String, int>()
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
      emoji: habitData['emoji'] ?? "😢",
      dates: {}
    );
  }

  Future<void> toggleCompletion(String token, String habitId, String date) async {
    await _habitService.toggleCompletion(token, habitId, date);
  }

  Future<Map<String, dynamic>> updateHabit(String habitId, Map<String, dynamic> data) async {
    return await _habitService.updateHabit(habitId, data);
  }

  Future<void> deleteHabit(String token, String habitId) async {
    await _habitService.deleteHabit(token, habitId);
  }

  Future<void> unlinkFriend(String userId, String habitId) async {
    await _habitService.unlinkFriend(userId, habitId);
  }

  Future<List<Friend>> getFriends(String habitId, String currUserId) async {
    final friendsData = await _habitService.getFriends(habitId);
    return friendsData.map((friend) {
      return Friend(
        profile: User(
          id: friend['user']['_id'],
          username: friend['user']['username'],
          name: friend['user']['name'],
          email: friend['user']['email'],
          profileImageUrl: friend['user']['profilePic'],
        ),
        dates: (friend['dates']).cast<String, int>(),
        isUser: friend['user']['_id'] == currUserId
      );
    }).toList();
  }

  Future<Habit> getHabit(String habitId) async {
    final habitData = await _habitService.getHabit(habitId);
    return Habit(
      id: habitData['_id'],
      title: habitData['title'],
      description: habitData['description'],
      createdBy: habitData['createdBy']["name"],
      emoji: habitData['emoji'] ?? "😢",
      dates: {}
    );
  }

  Future<void> joinFriend(String token, String habitId) async {
    await _habitService.joinFriend(token, habitId);
  }
}