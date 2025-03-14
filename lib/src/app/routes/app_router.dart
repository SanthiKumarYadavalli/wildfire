import 'package:flutter_native_splash/flutter_native_splash.dart';
import "package:go_router/go_router.dart";
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/presentation/screens/habit.dart';
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
  return GoRouter(routes: [
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
      redirect: (context, state) {
        if (auth is AsyncData && auth.value != "") {
          return null;
        }
        return '/login';
      }
    ),
    GoRoute(
      path: "/habit/:id",
      builder: (context, state) => HabitScreen(id: state.pathParameters['id']!),
    ),
  ],
  redirect: (context, state) {
    if (auth is AsyncData && auth.value != "" && JwtDecoder.isExpired(auth.value!)) {
      return '/login';
    }
    return null;
  }
  );
}
