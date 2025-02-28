import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_provider.g.dart';

@riverpod
class CurrDate extends _$CurrDate {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void updateDate(DateTime date) {
    state = date;
  }
}