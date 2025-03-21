import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_model.freezed.dart';
part 'habit_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String title,
    required String description,
    required String createdBy,
    required Map<String, int> dates,
  }) = _Habit;

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);
}