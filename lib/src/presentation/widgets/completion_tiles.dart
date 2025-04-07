import 'package:flutter/material.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/utils/streak_utils.dart';

class CompletionTiles extends StatelessWidget {
  const CompletionTiles({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    final numCompletions = getNumCompletions(habit.dates);

    final now = DateTime.now();
    final int weekTotal = 7;
    final int monthTotal = DateUtils.getDaysInMonth(now.year, now.month);
    final int yearTotal = isLeapYear(now.year) ? 366 : 365;

    return Column(
      children: [
        _buildCompletionTile(context, "Week", numCompletions["week"]!, weekTotal),
        _buildCompletionTile(context, "Month", numCompletions["month"]!, monthTotal),
        _buildCompletionTile(context, "Year", numCompletions["year"]!, yearTotal),
      ],
    );
  }
}

Widget _buildCompletionTile(BuildContext context, String title, int value, int total) {
  final theme = Theme.of(context);
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              Text("$value / $total", style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary))
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: value / total,
            color: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          )
        ],
      ),
    ),
  );
}