import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/domain/model/todo_list_model.dart';
import 'package:flutter_base_riverpod/presentation/features/home/home_screen.dart';
import 'package:flutter_base_riverpod/presentation/features/login_screen.dart';
import 'package:flutter_base_riverpod/presentation/features/splash_screen.dart';
import 'package:flutter_base_riverpod/presentation/features/todo/todo_form_screen.dart';
import 'package:flutter_base_riverpod/shared/routes/route_constant.dart';
import 'package:flutter_base_riverpod/shared/routes/router_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      // refreshListenable: RouterRefresh(ref.watch(authRepositoryProvider).authStateChanges()), // handle listen auth state
      debugLogDiagnostics: true,
      redirect: (context, state) {
        // handle auth state
        // final isLoggedIn = ref.watch(authRepositoryProvider).currentUser != null;
        final isLoggedIn = true;
        if (isLoggedIn) {
          if (state.matchedLocation.startsWith(Routes.loginScreen)) {
            return Routes.homeScreen;
          }
        } else {
          if (state.matchedLocation.startsWith(Routes.homeScreen)) {
            return Routes.loginScreen;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
            path: Routes.splash,
            builder: (context, state) => const SplashScreen()),
        GoRoute(
            path: Routes.loginScreen,
            builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: Routes.homeScreen,
            pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const HomeScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                )),
        GoRoute(
            path: Routes.todoFormScreen,
            pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: TodoFormScreen(state.extra as Todo?),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                )),
      ]);
});
