import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String username, 
    required String email,
    required String name,
    required String profileImageUrl,
  }) = _User;
}
