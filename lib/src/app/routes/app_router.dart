import "package:go_router/go_router.dart";
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/presentation/screens/create_habit.dart';
import '../../presentation/screens/login.dart';
import '../../presentation/screens/home.dart';
import '../../providers/auth_provider.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(ref) {
  final AsyncValue<String> auth = ref.watch(authProvider);
  return GoRouter(routes: [
    GoRoute(
      path: "/login",
      builder: (context, state) => LoginScreen(),
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
      path: "/create-habit",
      builder: (context, state) => CreateHabitScreen(),
    )
  ],
  redirect: (context, state) {
    if (auth is AsyncData && auth.value != "" && JwtDecoder.isExpired(auth.value!)) {
      return '/login';
    }
    return null;
  }
  );
}
