import 'dart:io';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/data/models/user_model.dart';
import 'package:wildfire/src/data/repositories/user_repository.dart';
import 'package:wildfire/src/providers/auth_provider.dart';

part 'user_provider.g.dart';

@riverpod
class CurrUser extends _$CurrUser {
  final UserRepository _userRepository = UserRepository();
  @override
  FutureOr<User?> build() async {
    final token = ref.read(loginProvider).requireValue;
    if (token != '') {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final theUser = await _userRepository.getUser(decodedToken['id']);
      return theUser;
    }
    return null;
  }

  void updateName(String name) async {
    final token = ref.read(loginProvider).requireValue;
    final decodedToken = JwtDecoder.decode(token);
    final prevState = state.value;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newName = await _userRepository.updateName(decodedToken['id'], name);
      return prevState!.copyWith(name: newName);
    });
  }

  void updateProfileImage(File image) async {
    final token = ref.read(loginProvider).requireValue;
    final decodedToken = JwtDecoder.decode(token);
    final prevState = state.value;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newProfileImageUrl = await _userRepository.updateProfileImage(decodedToken['id'], image);
      return prevState!.copyWith(profileImageUrl: newProfileImageUrl);
    });
  }
}