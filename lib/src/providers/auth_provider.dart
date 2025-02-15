import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/data/repositories/auth_repository.dart';

part 'auth_provider.g.dart';

final AuthRepository authRepository = AuthRepository();

@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<String> build() {
    return "";
  }

  Future<void> login(Map<String, dynamic> formData) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await authRepository.login(formData);
    });
  }

  void logout() {
    state = AsyncValue.data("");
  }
}