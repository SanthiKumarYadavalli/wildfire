import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/presentation/widgets/emoji_picker.dart';
import 'package:wildfire/src/providers/emoji_provider.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class CreateHabitScreen extends ConsumerWidget {
  CreateHabitScreen({super.key});
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(userHabitsProvider);
    final emoji = ref.watch(emojiProvider);
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
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create a New Habit", style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              fontWeight: Theme.of(context).textTheme.headlineSmall!.fontWeight,
            )),
            SizedBox(height: 30),
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
            SizedBox(height: 12),
            FormField<String>(
              builder: (FormFieldState<String> field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Pick an icon emoji",
                    errorText: field.errorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return MyEmojiPicker(onSelected: (emoji) {
                            ref.read(emojiProvider.notifier).setEmoji(emoji);
                          });
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(emoji, style: TextStyle(fontSize: 30)),
                          Spacer(),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  ref.read(userHabitsProvider.notifier).createHabit(
                        _titleController.text,
                        _descriptionController.text,
                        emoji,
                      );
                },
                child: (habits is AsyncLoading)
                    ? CircularProgressIndicator()
                    : Text("Create Habit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
