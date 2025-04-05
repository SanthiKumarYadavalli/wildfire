import 'package:flutter_native_splash/flutter_native_splash.dart';
import "package:go_router/go_router.dart";
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/presentation/screens/forgot_password.dart';
import 'package:wildfire/src/presentation/screens/join_habit.dart';
import 'package:wildfire/src/presentation/screens/profile.dart';
import 'package:wildfire/src/presentation/screens/habit.dart';
import 'package:wildfire/src/presentation/screens/reset_password.dart';
import 'package:wildfire/src/presentation/screens/signup.dart';
import '../../presentation/screens/login.dart';
import '../../presentation/screens/home.dart';
import '../../providers/auth_provider.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(ref) {
  final AsyncValue<String> auth = ref.watch(loginProvider);
  auth.whenData((data) {
    FlutterNativeSplash.remove();
  });
  return GoRouter(
    routes: [
      GoRoute(
        path: "/login",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: "/habit/:id",
        builder: (context, state) => HabitScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: "/join/:id",
        builder: (context, state) => HabitJoinScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: "/profile",
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: "/forgot-password",
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: "/reset-password/:token",
        builder: (context, state) => ResetPasswordScreen(token: state.pathParameters['token']!),
      )
    ],
    redirect: (context, state) {
      final AsyncValue<String> authState = ref.read(loginProvider);
      final loggedIn = authState.maybeWhen(
        data: (data) => data != "" && !JwtDecoder.isExpired(data),
        orElse: () => false,
      );
      final isLoginPage = state.matchedLocation == "/login" || 
                          state.matchedLocation == "/signup" ||
                          state.matchedLocation == "/forgot-password" ||
                          state.matchedLocation == "/reset-password/${state.pathParameters['token']}";
      if (loggedIn && isLoginPage) {
        return "/";
      } else if (!loggedIn && !isLoginPage) {
        return "/login";
      }
      return null;
    }
  );
}
