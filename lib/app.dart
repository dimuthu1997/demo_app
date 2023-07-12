import 'dart:async';

import 'package:demo_app/model/user.dart';
import 'package:demo_app/router/router.dart';
import 'package:demo_app/services/provider/app_state.dart';
import 'package:demo_app/services/provider/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  late DemoAppRouter router;
  late AppStateProvider _appStateProvider;
  late AuthService _authService;
  late StreamSubscription<User?> _authSubscription;

  @override
  void initState() {
    _appStateProvider = AppStateProvider.instance;
    router = DemoAppRouter(_appStateProvider);
    _authService = AuthService.instance;
    _authSubscription = _authService.onAuthStateChanged
        .listen((event) async => await onAuthStateChanged(event));
    super.initState();
  }

  Future<void> onAuthStateChanged(User? user) async {
    _appStateProvider.currentUser = user;
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        builder: (context, child) => Builder(builder: (context) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.light,
                routerConfig: router.router,
              );
            }),
        providers: [
          ChangeNotifierProvider(create: (_) => _appStateProvider),
          ChangeNotifierProvider(create: (_) => _authService),
        ]);
  }
}
