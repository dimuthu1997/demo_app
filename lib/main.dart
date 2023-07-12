import 'package:demo_app/app.dart';
import 'package:demo_app/services/provider/app_state.dart';
import 'package:demo_app/services/provider/authentication.dart';
import 'package:demo_app/services/shared_pref.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const DemoApp());
}

Future<void> initialize() async {
  await AppStateProvider.initialize();
  await StorageService.initialize();
  await AuthService.initialize();
}
