import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wildfire/src/presentation/screens/create_habit.dart';
import 'package:wildfire/src/presentation/widgets/appbar_home.dart';
import 'package:wildfire/src/providers/date_provider.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(userHabitsProvider);
    final currDate = ref.watch(currDateProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(161),
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
            if (data.isEmpty) {
              return Text("Add a new habit!");
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final formattedDate = DateFormat("yyyy-MM-dd").format(currDate);
                final isCompleted = data[index].dates.containsKey(formattedDate);
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(149, 157, 165, 0.2),
                        blurRadius: 24,
                        spreadRadius: 0,
                        offset: Offset(0, 8),
                      ),   
                    ],
                    border: Border(
                      left: BorderSide(
                        color: (isCompleted) ? Colors.deepOrange : Colors.grey,
                        width: 5,
                      ),
                    ),
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      data[index].title,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: Theme.of(context).textTheme.titleMedium!.fontWeight,
                      ),
                    ),
                    trailing: IconButton(
                      icon: (isCompleted) 
                            ? Icon(Icons.local_fire_department_sharp, color: Colors.deepOrange, size: 40) 
                            : Icon(Icons.local_fire_department_outlined, color: Colors.grey, size: 40),
                      onPressed: () {
                        ref.read(userHabitsProvider.notifier).toggleCompletion(data[index].id, formattedDate);
                      },
                    ),
                  ),
                );
              },
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => Text("Error: $error"),
        )
      ),
    );
  }
}