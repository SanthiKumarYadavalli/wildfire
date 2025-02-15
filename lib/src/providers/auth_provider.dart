import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/data/repositories/auth_repository.dart';

part 'auth_provider.g.dart';

final AuthRepository authRepository = AuthRepository();

@riverpod
class Auth extends _$Auth {
  @override
  Map<String, dynamic> build() {
    return {
      "token": "",
      "error": false,
    };
  }

  Future<void> login(Map<String, dynamic> formData) async {
    state["error"] = false;
    try {
      final token = await authRepository.login(formData);
      state["token"] = token;
    } catch (e) {
      state["error"] = true;
    }
  }

  void logout() {
    state["token"] = "";
  }
}