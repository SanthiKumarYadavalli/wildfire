import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wildfire/src/presentation/widgets/emoji_picker.dart';
import 'package:wildfire/src/presentation/widgets/habit_screen/delete_habit_dialog.dart';
import 'package:wildfire/src/presentation/widgets/habit_screen/edit_habit_form.dart';
import 'package:wildfire/src/presentation/widgets/habit_screen/friends_tab/friends_tab.dart';
import 'package:wildfire/src/presentation/widgets/habit_screen/stats_tab/habit_statistics.dart';
import 'package:wildfire/src/presentation/widgets/habit_screen/leave_habit_dialog.dart';
import 'package:wildfire/src/providers/habit_provider.dart';
import 'package:wildfire/src/providers/user_provider.dart';

class HabitScreen extends ConsumerWidget {
  const HabitScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(userHabitsProvider).requireValue;
    final habit = habits.firstWhere((element) => element.id == id);
    final friendStats = ref.watch(habitFriendsProvider(habit.id));
    final isCreator = habit.createdBy == ref.read(currUserProvider).requireValue!.id;
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(habit.title),
          bottom: TabBar(
            tabs: [
              Tab(text: "Statistics"),
              Tab(text: "Friends"),
            ],
          ),
          actions: [
            MenuAnchor(
              style: MenuStyle(
                backgroundColor: WidgetStateProperty.all(colorScheme.surfaceContainerHighest),
                shadowColor: WidgetStateProperty.all(colorScheme.onSurface),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
                padding: WidgetStateProperty.all(EdgeInsets.all(8)),
              ),
              menuChildren: [
                // ADD FRIENDS
                MenuItemButton(
                  leadingIcon: Icon(Icons.person_add),
                  child: Text("Add Friends"),
                  onPressed: () {
                    Share.share("Join my habit: ${habit.title} at https://wildfire-client.vercel.app/join/${habit.id}");
                  },
                ),

                // EDIT ICON
                isCreator
                ? MenuItemButton(
                  leadingIcon: Icon(Icons.emoji_emotions),
                  child: Text("Edit Icon"),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context, 
                      builder: (context) {
                        return MyEmojiPicker(onSelected: (emoji) {
                          ref.read(userHabitsProvider.notifier).updateHabit(habit.id, {
                            "emoji": emoji
                          });
                          context.pop();
                        });
                      }
                    );
                  }
                )
                : Container(),

                // EDIT HABIT
                isCreator 
                ?  MenuItemButton(
                    leadingIcon: Icon(Icons.edit),
                    child: Text("Edit"),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero)
                        ),
                        builder: (context) {
                          return EditHabitForm(habit: habit);
                        },
                      );
                    },
                  )
                : Container(),

                // DELETE HABIT / LEAVE HABIT
                isCreator
                ? MenuItemButton(
                  onPressed: () => showDialog(
                    context: context, 
                    builder: (context) => DeleteHabitDialog(habitId: habit.id)
                  ),  
                  leadingIcon: Icon(Icons.delete_forever),
                  child: Text("Delete"),
                )
                : MenuItemButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => LeaveHabitDialog(habitId: habit.id),
                  ),
                  leadingIcon: Icon(Icons.logout),
                  child: Text("Leave"),
                )
              ],
              builder: (context, controller, child) {
                return IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            HabitStatistics(habit: habit),
            FriendsTab(habitId: id, friendStats: friendStats),
          ],
        )
      ),
    );
  }
}