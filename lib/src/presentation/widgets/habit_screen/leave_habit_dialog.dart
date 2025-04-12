import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class LeaveHabitDialog extends ConsumerWidget {
  const LeaveHabitDialog({super.key, required this.habitId});
  final String habitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Are you sure?"),
      content: const Text("You will be removed from this habit."),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            ref.read(userHabitsProvider.notifier).leaveHabit(habitId);
            context.pop();
            context.pop();
          },
          child: const Text("Leave", style: TextStyle(color: Colors.red)),
        )
      ],
    );
  }
}
