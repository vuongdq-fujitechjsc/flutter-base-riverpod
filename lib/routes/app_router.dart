import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/features/home/home_screen.dart';
import 'package:flutter_base_riverpod/features/login/login_screen.dart';
import 'package:flutter_base_riverpod/features/splash/splash_screen.dart';
import 'package:flutter_base_riverpod/routes/route_constant.dart';
import 'package:flutter_base_riverpod/routes/router_refresh.dart';
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
          if (state.matchedLocation.startsWith(Routes.loginPage)) {
            return Routes.homePage;
          }
        } else {
          if (state.matchedLocation.startsWith(Routes.homePage)) {
            return Routes.loginPage;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
            path: Routes.splash,
            builder: (context, state) => const SplashScreen()),
        GoRoute(
            path: Routes.loginPage,
            builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: Routes.homePage,
            pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const HomeScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                ))
      ]);
});
