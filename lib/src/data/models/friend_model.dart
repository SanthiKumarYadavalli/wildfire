import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wildfire/src/data/models/user_model.dart';

part 'friend_model.freezed.dart';
part 'friend_model.g.dart';

@freezed
class Friend with _$Friend {
  const factory Friend({
    required User profile,
    required Map<String, int> dates,
  }) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
}