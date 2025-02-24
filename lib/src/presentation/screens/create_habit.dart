import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class CreateHabitScreen extends ConsumerWidget {
  CreateHabitScreen({super.key});
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(userHabitsProvider);
    ref.listen(userHabitsProvider, (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
        ));
      }
      if (state is AsyncData) {
        context.pop();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Habit"),
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Title",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(userHabitsProvider.notifier).createHabit(
                  _titleController.text,
                  _descriptionController.text,
                );
              },
              child: (habits is AsyncLoading) ? CircularProgressIndicator() : Text("Create Habit"),
            ),
          ],
        ),
      ),
    );
  }
}