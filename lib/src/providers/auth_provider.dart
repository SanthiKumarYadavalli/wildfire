import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/data/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.g.dart';

final AuthRepository authRepository = AuthRepository();

@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<String> build() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  Future<void> login(Map<String, dynamic> formData) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final token = await authRepository.login(formData);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", token);
      return token;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    state = const AsyncValue.data("");
  }

  Future<void> signup(Map<String, dynamic> formData) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await authRepository.signup(formData);
      return "";
    });
  }
}
