import 'package:flutter/material.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/presentation/widgets/completion_tiles.dart';
import 'package:wildfire/src/presentation/widgets/streak_calendar.dart';
import 'package:wildfire/src/presentation/widgets/streak_cards.dart';

class HabitStatistics extends StatelessWidget {
  const HabitStatistics({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Habit Info ---
            Center(
              child: Column(
                 children: [
                   Text(
                     habit.title,
                     style: textTheme.headlineMedium?.copyWith(
                       color: colorScheme.onSurface,
                     ),
                     textAlign: TextAlign.center,
                   ),
                    const SizedBox(height: 8),
                    Text(
                      habit.description,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                 ],
               ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),

            Text(
              "Calendar",
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            StreakCalendar(habit: habit),
            const SizedBox(height: 24),

            Text(
              "Streaks",
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),

            StreakCards(habit: habit),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),

            Text(
              "Completions",
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            CompletionTiles(habit: habit),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}