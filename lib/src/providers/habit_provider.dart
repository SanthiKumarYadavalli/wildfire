import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/data/models/friend_model.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/data/repositories/habit_repository.dart';
import 'package:wildfire/src/providers/auth_provider.dart';
import 'package:wildfire/src/providers/user_provider.dart';
import 'package:wildfire/src/providers/calendar_provider.dart';
import 'package:wildfire/src/utils/streak_utils.dart';

part 'habit_provider.g.dart';

final HabitRepository habitRepository = HabitRepository();

@riverpod
class UserHabits extends _$UserHabits {
  @override
  FutureOr<List<Habit>> build() async {
    final token = await ref.watch(loginProvider.future);
    if (token != '') {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final habits = await habitRepository.getHabits(decodedToken['id']);
      return habits;
    }
    return [];
  }

  void createHabit(title, description, emoji) async {
    final token = ref.read(loginProvider).requireValue;
    final prevState = state.value;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newHabit = await habitRepository.createHabit(token, {
        'title': title,
        'description': description,
        'emoji': emoji,
      });
      return [...prevState!, newHabit];
    });
  }

  void toggleCompletion(String habitId, String date) async {
    final token = ref.read(loginProvider).requireValue;
    final prevState = state.value;
    ref.read(loadingHabitsProvider.notifier).add(habitId);
    ref.read(loadingDatesProvider.notifier).add(date);
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
    ref.read(loadingDatesProvider.notifier).remove(date);
  }

  void leaveHabit(String habitId) async {
    final userId = ref.read(currUserProvider).requireValue!.id;
    final prevState = state.value;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await habitRepository.unlinkFriend(userId, habitId);
      return prevState!.where((habit) => habitId != habit.id).toList();
    });
  }

  void deleteHabit(String habitId) async {
    final token = ref.read(loginProvider).requireValue;
    final prevState = state.value;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await habitRepository.deleteHabit(token, habitId);
      return prevState!.where((habit) => habit.id != habitId).toList();
    });
  }

  void updateHabit(String habitId, Map<String, dynamic> data) async {
    final prevState = state.value;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updatedHabit = await habitRepository.updateHabit(habitId, data);
      return prevState!.map((habit) {
        if (habit.id == habitId) {
          return habit.copyWith(
            title: updatedHabit['title'],
            description: updatedHabit['description'],
            emoji: updatedHabit['emoji'],
          );
        }
        return habit;
      }).toList();
    });
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
class HabitFriends extends _$HabitFriends {
  @override
  FutureOr<List<Map<String, dynamic>>> build(habitId) async {
    final currUserId = await ref.watch(currUserProvider.future);
    final friends = await habitRepository.getFriends(habitId, currUserId!.id);
    var friendStats = <Map<String, dynamic>>[];
    for (Friend friend in friends) {
      final currStats = <String, dynamic>{};
      final streaks = getCurrAndMaxStreaks(friend.dates);
      final completions = getNumCompletions(friend.dates);
      currStats['friend'] = friend;
      currStats['streak'] = streaks.$1;
      currStats['best_streak'] = streaks.$2;
      currStats['week'] = completions["week"];
      currStats['month'] = completions["month"];
      currStats['year'] = completions["year"];
      friendStats.add(currStats);
    }
    final selectedValue = ref.read(friendsDisplayValueProvider);
    friendStats.sort((a, b) => b[selectedValue].compareTo(a[selectedValue]));
    return friendStats;
  }

  void sortBySelectedValue(String selectedValue) {
    state.value!.sort((a, b) {
      return b[selectedValue].compareTo(a[selectedValue]);
    });
    state = state;
  }
}

@riverpod
class FriendsDisplayValue extends _$FriendsDisplayValue {
  @override
  String build() {
    return "week";
  }

  void update(String value) {
    state = value;
  }
}

@riverpod
FutureOr<Habit> getHabit(Ref ref, String habitId) async {
  final habit = await habitRepository.getHabit(habitId);
  return habit;
}

@riverpod
class JoinFriend extends _$JoinFriend {
  @override
  FutureOr<bool> build(String habitId) async {
    final habits = await ref.watch(userHabitsProvider.future);
    return habits.any((habit) => habit.id == habitId);
  }

  void join() async {
    final token = await ref.watch(loginProvider.future);
    final userId = JwtDecoder.decode(token)['id'];
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await habitRepository.joinFriend(userId, habitId);
      return true;
    });
  }
}