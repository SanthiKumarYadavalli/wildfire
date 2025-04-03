import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/providers/calendar_provider.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class StreakCalendar extends ConsumerWidget {
  const StreakCalendar({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingDates = ref.watch(loadingDatesProvider);
    final focusedDay = ref.watch(focusedDayProvider);
    return TableCalendar(
      focusedDay: focusedDay,
      firstDay: DateTime(1947, 08, 15),
      lastDay: DateTime.now(),
      onDaySelected: (selectedDay, focusedDay) {
        ref.read(focusedDayProvider.notifier).set(focusedDay);
        ref.read(userHabitsProvider.notifier).toggleCompletion(
          habit.id, 
          DateFormat('yyyy-MM-dd').format(selectedDay)
        );
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      selectedDayPredicate: (day) {
        return habit.dates.containsKey(DateFormat('yyyy-MM-dd').format(day));
      },
      enabledDayPredicate: (day) {
        return !loadingDates.contains(DateFormat('yyyy-MM-dd').format(day));
      },
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        outsideDaysVisible: false,
        selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle),
        selectedTextStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
