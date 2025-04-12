import 'package:flutter/material.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/utils/streak_utils.dart';

class StreakCards extends StatelessWidget {
  const StreakCards({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    final (currentStreak, maxStreak) = getCurrAndMaxStreaks(habit.dates);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget buildStat({
      required int value,
      required IconData icon,
    }) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colorScheme.primary, size: 40),
            const SizedBox(width: 12),
            Text(
              value.toString(),
              style: theme.textTheme.displayMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          buildStat(
            value: currentStreak,
            icon: Icons.local_fire_department,
          ),
          const SizedBox(width: 16),
          buildStat(
            value: maxStreak,
            icon: Icons.star_rounded,
          ),
        ],
      ),
    );
  }
}