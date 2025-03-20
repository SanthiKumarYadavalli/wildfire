import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/presentation/widgets/delete_habit_dialog.dart';
import 'package:wildfire/src/presentation/widgets/friends_tab.dart';
import 'package:wildfire/src/presentation/widgets/habit_statistics.dart';
import 'package:wildfire/src/presentation/widgets/leave_habit_dialog.dart';
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
              menuChildren: [
                (habit.createdBy == ref.read(currUserProvider).requireValue!.id)
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