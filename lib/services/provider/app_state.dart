import 'package:demo_app/model/user.dart';
import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  AppStateProvider._();

  static AppStateProvider? _instance;
  User? _currentUser;
  static AppStateProvider get instance {
    if (_instance == null) {
      throw Exception('AppStateProvider is not initialized');
    }
    return _instance!;
  }

  static Future<AppStateProvider> initialize() async {
    if (_instance == null) {
      _instance = AppStateProvider._();
      return _instance!;
    } else {
      throw Exception('AppStateProvider is allready initialized');
    }
  }

  bool _isLoadingSplash = false;
  bool get isLoading => _isLoadingSplash;
  bool get isLoggedIn => _currentUser != null;
  User? get currentUser => _currentUser;

  set isLoading(bool splashScreen) {
    _isLoadingSplash = splashScreen;
    notifyListeners();
  }

  set currentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }
}
