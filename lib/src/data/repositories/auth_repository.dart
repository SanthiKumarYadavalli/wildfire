import 'package:wildfire/src/data/services/auth_service.dart';

class AuthRepository {
  final AuthService authService = AuthService();

  Future<String> login(data) async {
    final token = (await authService.loginUser(data['username'], data['password']))["token"];
    return token;
  }

  Future<void> signup(data) async {
    await authService.signupUser(data['name'], data['username'], data['email'], data['password']);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await authService.sendPasswordResetEmail(email);
  }
  
  Future<void> resetPassword(String token, String password) async {
    await authService.resetPassword(token, password);
  }
}
