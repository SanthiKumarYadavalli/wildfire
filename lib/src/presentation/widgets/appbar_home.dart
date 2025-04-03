import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/presentation/widgets/avatar_button.dart';
import 'package:wildfire/src/providers/date_provider.dart';

part 'appbar_home.g.dart'; 

@riverpod
CalendarSliderController calController(ref) {
  final controller = CalendarSliderController();
  ref.onDispose(() => controller.dispose());
  return controller;
}

class AppBarHome extends ConsumerWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currDate = ref.watch(currDateProvider);
    final calSliderController = ref.watch(calControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: Text(
            DateFormat("MMMM d").format(currDate),
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 4.0,
          surfaceTintColor: colorScheme.surfaceTint,

          leading: IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            tooltip: 'Select Date',
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: currDate,
                firstDate: DateTime(1947, 8, 15),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: colorScheme.copyWith(
                        primary: colorScheme.primary,
                        onPrimary: colorScheme.onPrimary,
                        onSurface: colorScheme.onSurface,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.primary,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null && !DateUtils.isSameDay(currDate, picked)) {
                calSliderController.goToDay(picked);
                ref.read(currDateProvider.notifier).updateDate(picked);
              }
            },
          ),

          actions: [
           DateUtils.isSameDay(currDate, DateTime.now())
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: () {
                    final now = DateTime.now();
                    if (!DateUtils.isSameDay(currDate, now)) {
                      calSliderController.goToDay(now);
                      ref.read(currDateProvider.notifier).updateDate(now);
                    }
                  },
                  child: const Text("Today"),
                ),
              ),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: AvatarButton(),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CalendarSlider(
            controller: calSliderController,
            fullCalendar: false,
            initialDate: currDate,
            firstDate: DateTime(1947, 8, 15),
            lastDate: DateTime.now(),
            selectedTileBackgroundColor: colorScheme.primary,
            selectedDateColor: colorScheme.onPrimary,
            tileBackgroundColor: colorScheme.surfaceContainerHighest,
            dateColor: colorScheme.onSurfaceVariant,
            tileShadow: BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
            
            onDateSelected: (date) {
              ref.read(currDateProvider.notifier).updateDate(date);
            },
          ),
        ),
      ],
    );
  }
}