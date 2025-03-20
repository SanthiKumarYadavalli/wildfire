import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_provider.g.dart';

@riverpod
class LoadingDates extends _$LoadingDates {
  @override
  Set<String> build() {
    return <String>{};
  }

  void add(String date) {
    state = {...state}..add(date);
  }

  void remove(String date) {
    state = {...state}..remove(date);
  }
}

@riverpod
class FocusedDay extends _$FocusedDay {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void set(DateTime day) {
    state = day;
  }
}