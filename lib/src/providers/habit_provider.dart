import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/data/models/friend_model.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/data/repositories/habit_repository.dart';
import 'package:wildfire/src/providers/auth_provider.dart';

part 'habit_provider.g.dart';

  final HabitRepository habitRepository = HabitRepository();

@riverpod
class UserHabits extends _$UserHabits {
  @override
  FutureOr<List<Habit>> build() async {
    final token = ref.read(loginProvider).requireValue;
    if (token != '') {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final habits = await habitRepository.getHabits(decodedToken['id']);
      return habits;
    }
    return [];
  }

  void createHabit(title, description) async {
    final token = ref.read(loginProvider).requireValue;
    final prevState = state.value;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newHabit = await habitRepository.createHabit(token, {
        'title': title,
        'description': description,
      });
      return [...prevState!, newHabit];
    });
  }

  void toggleCompletion(habitId, date) async {
    final token = ref.read(loginProvider).requireValue;
    final prevState = state.value;
    ref.read(loadingHabitsProvider.notifier).add(habitId);
    state = await AsyncValue.guard(() async {
      await habitRepository.toggleCompletion(token, habitId, date);
      return prevState!.map((habit) {
        if (habit.id == habitId) {
          if (habit.dates.containsKey(date)) {
            habit.dates.remove(date);
          } else {
            habit.dates[date] = 1;
          }
        }
        return habit;
      }).toList();
    });
    ref.read(loadingHabitsProvider.notifier).remove(habitId);
  }
}

@riverpod
class LoadingHabits extends _$LoadingHabits {
  @override
  Set<String> build() {
    return <String>{};
  }

  void remove(String habitId) {
    state = {...state}..remove(habitId);
  }

  void add(String habitId) {
    state = {...state}..add(habitId);
  }
}

@riverpod
FutureOr<List<Friend>> habitFriends(Ref ref, String habitId) async {
  return await habitRepository.getFriends(habitId);
}