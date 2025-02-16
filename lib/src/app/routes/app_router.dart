import "package:go_router/go_router.dart";
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
  ],
  );
}
