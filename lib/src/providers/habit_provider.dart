import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/data/repositories/habit_repository.dart';
import 'package:wildfire/src/providers/auth_provider.dart';

part 'habit_provider.g.dart';

@riverpod
class UserHabits extends _$UserHabits {
  final HabitRepository _habitRepository = HabitRepository();
  @override
  FutureOr<List<Habit>?> build() async {
    final token = ref.read(authProvider).requireValue;
    if (token != '') {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final habits = await _habitRepository.getHabits(decodedToken['id']);
      return habits;
    }
    return null;
  }

  void createHabit(title, description) async {
    final token = ref.read(authProvider).requireValue;
    final prevState = state.value;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newHabit = await _habitRepository.createHabit(token, {
        'title': title,
        'description': description,
      });
      return [...prevState!, newHabit];
    });
  }
}