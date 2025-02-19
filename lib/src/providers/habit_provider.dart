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
  FutureOr<List<Habit?>?> build() async {
    final token = ref.read(authProvider).requireValue;
    if (token != '') {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final habits = await _habitRepository.getHabits(decodedToken['id']);
      print(habits);
      return habits;
    }
    return null;
  }
}