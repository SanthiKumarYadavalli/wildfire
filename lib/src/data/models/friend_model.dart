import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wildfire/src/data/models/user_model.dart';

part 'friend_model.freezed.dart';

@freezed
class Friend with _$Friend {
  const factory Friend({
    required User profile,
    required Map<String, int> dates,
    @Default(false) bool isUser,
  }) = _Friend;
}