import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/data/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.g.dart';

final AuthRepository authRepository = AuthRepository();


@riverpod
Future<bool> verifyToken(Ref ref, String token) async {
  try {
    await authRepository.verifyToken(token);
    return true;
  } catch (e) {
    return false;
  }
}

@riverpod
class Login extends _$Login {
  @override
  FutureOr<String> build() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    if (token == null) {
      return "";
    }
    final isValid = await ref.watch(verifyTokenProvider(token).future);
    if (isValid) {
      return token;
    } else {
      prefs.remove("token");
      return "";
    }
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
}


@riverpod
class Signup extends _$Signup {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> signup(Map<String, dynamic> formData) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await authRepository.signup(formData);
      return;
    });
  }
}

@riverpod
class ForgotPassword extends _$ForgotPassword {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await authRepository.sendPasswordResetEmail(email);
      return true;
    });
  }
}

@riverpod
class ResetPassword extends _$ResetPassword {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> resetPassword(String token, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await authRepository.resetPassword(token, password);
      return true;
    });
  }
}