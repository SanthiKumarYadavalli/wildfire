import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/presentation/widgets/avatar_button.dart';
import 'package:wildfire/src/providers/date_provider.dart';

part 'appbar_home.g.dart';

@riverpod
CalendarSliderController calController(Ref ref) {
  return CalendarSliderController();
}

class AppBarHome extends ConsumerWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currDate = ref.watch(currDateProvider);
    final calcontroller = ref.watch(calControllerProvider);

    return Column(children: [
      AppBar(
        title: Text(DateFormat("MMM yyyy").format(currDate)),
        centerTitle: true,
        forceMaterialTransparency: true,
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
                calcontroller.goToDay(picked);
              }
            }),
        actions: [
          TextButton(
            child: Text("Today"),
            onPressed: () {
              calcontroller.goToDay(DateTime.now());
            },
          ),
          AvatarButton(),
        ],
      ),
      CalendarSlider(
        controller: calcontroller,
        fullCalendar: false,
        initialDate: DateTime.now(),
        firstDate: DateTime.parse("1947-08-15"),
        lastDate: DateTime.now(),
        selectedTileBackgroundColor: Theme.of(context).colorScheme.primary,
        selectedDateColor: Theme.of(context).colorScheme.onPrimary,
        tileBackgroundColor: Theme.of(context).colorScheme.surface,
        dateColor: Theme.of(context).colorScheme.onSurface,
        onDateSelected: (date) {
          ref.read(currDateProvider.notifier).updateDate(date);
        },
      ),
    ]);
  }
}
