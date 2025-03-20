import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class DeleteHabitDialog extends ConsumerWidget {
  const DeleteHabitDialog({super.key, required this.habitId});
  final String habitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Are you sure?"),
      content: const Text("This habit will be deleted permanently"),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            ref.read(userHabitsProvider.notifier).deleteHabit(habitId);
            context.pop();
            context.pop();
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        )
      ],
    );
  }
}
