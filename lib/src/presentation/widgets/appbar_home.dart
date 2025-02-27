import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';
import 'package:wildfire/src/presentation/widgets/avatar_button.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({super.key});

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  final _calcontroller = CalendarSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
            }),
        actions: [
          TextButton(
            child: Text("Today"),
            onPressed: () {
              _calcontroller.goToDay(DateTime.now());
            },
          ),
          AvatarButton(),
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
    ]);
  }
}
