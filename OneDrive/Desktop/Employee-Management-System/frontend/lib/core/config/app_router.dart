import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../layouts/app_shell.dart';

import '../../../features/auth/presentation/providers/auth_notifier.dart';
import '../../../features/auth/presentation/screens/login_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {

  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: "/",

    redirect: (context, state) {

      final isLoggedIn = authState.isAuthenticated;
      final isLoginPage = state.uri.path == "/login";

      if (!isLoggedIn && !isLoginPage) {
        return "/login";
      }

      if (isLoggedIn && isLoginPage) {
        return "/";
      }

      return null;
    },

    routes: [

      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: "/",
        builder: (context, state) => const AppShell(),
      ),

    ],
  );
});