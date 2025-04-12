import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class EditHabitForm extends ConsumerWidget {
  const EditHabitForm({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: habit.title);
    final descriptionController = TextEditingController(text: habit.description);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Habit', 
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              autofocus: true,
            ),
            SizedBox(height: 10),
            TextField(
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              controller: descriptionController,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    ref.read(userHabitsProvider.notifier)
                        .updateHabit(
                          habit.id,
                          {
                            'title': titleController.text,
                            'description': descriptionController.text,
                          }
                        );
                    context.pop();
                    context.pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}