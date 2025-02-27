import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/providers/auth_provider.dart';
import 'package:wildfire/src/providers/habit_provider.dart';
import 'package:wildfire/src/providers/user_provider.dart';
import 'package:calendar_slider/calendar_slider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  
  final _calcontroller = CalendarSliderController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currUserProvider);
    final habits = ref.watch(userHabitsProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(161), 
        child: Column(
          children: [
            AppBar(
              title: Text("Wildfire"),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.calendar_month_rounded),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1947, 8, 15),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _calcontroller.goToDay(picked);
                  }
                }
              ),
              actions: [
                TextButton(
                  child: Text("Today"),
                  onPressed: () {
                    _calcontroller.goToDay(DateTime.now());
                  },
                ),
                MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () => ref.read(authProvider.notifier).logout(),
                      leadingIcon: Icon(Icons.logout),
                      child: Text("Logout"),
                    )
                  ],
                  builder: (context, controller, child) {
                    return user.when(
                      data: (data) {
                        return IconButton(
                          icon: CircleAvatar(
                            backgroundImage: NetworkImage(data!.profileImageUrl),
                          ),
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          }
                        );
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (error, stackTrace) => Icon(Icons.error),
                    );
                  },
                )
              ],
            ),
            CalendarSlider(
              controller: _calcontroller,
              fullCalendar: false,
              initialDate: DateTime.now(),
              firstDate: DateTime.parse("1947-08-15"),
              lastDate: DateTime.now(),
              selectedTileBackgroundColor: Theme.of(context).colorScheme.primary,
              selectedDateColor: Theme.of(context).colorScheme.onPrimary,
              tileBackgroundColor: Theme.of(context).colorScheme.surface,
              dateColor: Theme.of(context).colorScheme.onSurface,
              onDateSelected: (date) {
                print(date);
              },
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push("/create-habit");
        },
        tooltip: "Add a new habit",
        child: Icon(Icons.add),
      ),
      body: Center(
        child: habits.when(
          data: (data) {
            if (data!.isEmpty) {
              return Text("Add a new habit!");
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]!.title),
                  subtitle: Text(data[index]!.description),
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