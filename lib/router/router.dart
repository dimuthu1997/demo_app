import 'package:demo_app/views/auth/signin.dart';
import 'package:demo_app/views/auth/signup.dart';
import 'package:demo_app/views/home/home.dart';
import 'package:demo_app/views/other/splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/provider/app_state.dart';

class DemoAppRouter {
  final AppStateProvider _appStateProvider;
  DemoAppRouter(this._appStateProvider);

  GoRouter get router => _goRouter;

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: _appStateProvider,
    initialLocation: '/home',
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const SplashScreenPage()),
      ),
      GoRoute(
        path: '/signin',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const SignInPage()),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const SignUpPage()),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const HomePage()),
      ),
    ],
    redirect: (context, state) {
      bool isLoading = _appStateProvider.isLoading;
      bool isLoggedIn = _appStateProvider.isLoggedIn;

      final bool isGoingToSplash = state.matchedLocation == "/splash";
      final bool isGoingToSignin = state.matchedLocation == "/signin";
      final bool isGoingToHome = state.matchedLocation == "/home";

      if (!isLoading && !isGoingToSplash) {
        return "/splash";
      }
      if (isLoading && !isLoggedIn && !isGoingToSignin) {
        return "/signin";
      }
      if (isLoading && isLoggedIn && !isGoingToHome) {
        return "/home";
      }

      return null;
    },
  );
}
