import 'package:flutter/material.dart';
import '../../../../data/model/todo_list_model.dart';
import 'package:flutter_base_riverpod/presentation/features/home/home_screen.dart';
import 'package:flutter_base_riverpod/presentation/features/auth/login_screen.dart';
import 'package:flutter_base_riverpod/presentation/features/setting/setting_screen.dart';
import 'package:flutter_base_riverpod/presentation/features/splash_screen.dart';
import 'package:flutter_base_riverpod/presentation/features/todo/todo_form_screen.dart';
import 'package:flutter_base_riverpod/shared/routes/route_constant.dart';
import 'package:flutter_base_riverpod/shared/routes/router_refresh.dart';
import 'package:flutter_base_riverpod/shared/widgets/scaffold_with_navbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();
final _sectionNavigationKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      // refreshListenable: RouterRefresh(ref.watch(authRepositoryProvider).authStateChanges()), // handle listen auth state
      navigatorKey: _rootNavigationKey,
      initialLocation: Routes.splashScreen,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        // handle auth state
        // final isLoggedIn = ref.watch(authRepositoryProvider).currentUser != null;
        final isLoggedIn = false;
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
      routes: <RouteBase>[
        GoRoute(
            path: Routes.splashScreen,
            builder: (context, state) => const SplashScreen()),
        GoRoute(
            path: Routes.loginScreen,
            builder: (context, state) => const LoginScreen()),

        // Setup tabbar
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              // Return the widget that implement the custom shell - as a BottomNavigationBar
              return ScaffoldWithNavBar(navigationShell);
            },
            branches: [
              // Setup tab 1
              StatefulShellBranch(
                  navigatorKey: _sectionNavigationKey,
                  routes: <RouteBase>[
                    GoRoute(
                      path: Routes.homeScreen,
                      builder: (context, state) => const HomeScreen(),
                    ),
                    GoRoute(
                        path: Routes.todoFormScreen,
                        pageBuilder: (context, state) => CustomTransitionPage(
                              key: state.pageKey,
                              child: TodoFormScreen(state.extra as Todo?),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  FadeTransition(
                                      opacity: animation, child: child),
                            )),
                  ]),

              // Setup for tab 2
              StatefulShellBranch(routes: <RouteBase>[
                GoRoute(
                  path: Routes.settingScreen,
                  builder: (context, state) => const SettingScreen(),
                )
              ]),
            ])
      ]);
});
