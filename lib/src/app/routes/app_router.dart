import "package:go_router/go_router.dart";
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../presentation/screens/login.dart';
import '../../presentation/screens/home.dart';
import '../../providers/auth_provider.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(ref) {
  final authState = ref.watch(authProvider);
  return GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: "/login",
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      redirect: (context, state) {
        if (authState["token"] == "") {
          return "/login";
        }
        return null;
      },
    )
  ]);
}
