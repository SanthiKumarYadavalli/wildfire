import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/presentation/screens/create_habit.dart';
import 'package:wildfire/src/presentation/screens/error.dart';
import 'package:wildfire/src/presentation/widgets/appbar_home.dart';
import 'package:wildfire/src/presentation/widgets/habits_list.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(userHabitsProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(177),
        child: AppBarHome(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            showDragHandle: true,
            builder: (context) {
              return CreateHabitScreen();
            },
          );
        },
        tooltip: "Add a new habit",
        child: Icon(Icons.add),
      ),
      body: Center(
        child: habits.when(
          data: (data) {
            return HabitsList(data: data);
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => ErrorScreen(
            errorMsg: "Can't load habits",
            provider: userHabitsProvider,
          )
        )
      ),
    );
  }
}