import 'dart:async';
import 'dart:convert';
import 'package:demo_app/model/data.dart';
import 'package:demo_app/model/user.dart';
import 'package:demo_app/services/shared_pref.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  static AuthService? _instance;
  final StorageService _storageService = StorageService.instance;
  AuthService._();

  User? _user;
  Data? users = Data();
  final StreamController<User?> _streamController =
      StreamController.broadcast();

  Stream<User?> get onAuthStateChanged => _streamController.stream;
  User? get user => _user;

  static Future<AuthService> initialize() async {
    _instance ??= AuthService._();
    return _instance!;
  }

  static AuthService get instance {
    if (_instance == null) {
      throw Exception('AuthService is not initialized');
    }
    return _instance!;
  }

  register(
    String email,
    String password,
  ) async {
    try {
      User userRegister = User(
        email: email,
        password: password,
      );
      _saveUser(userRegister);
    } catch (e) {
      return Exception(e);
    }
  }

  bool login(
    String email,
    String password,
  ) {
    try {
      User userLogin = User(
        email: email,
        password: password,
      );
      bool? result = users?.database.any(
        (element) => element == userLogin,
      );
      if (result == true) {
        _saveUser(userLogin);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }

  logout() async {
    try {
      clearUser();
    } catch (e) {
      return Exception(e);
    }
  }

  Future<bool> _saveUser(User user) async {
    bool result =
        await _storageService.setString("userKey", jsonEncode(user.toMap()));
    if (!result) {
      _user = null;
      _streamController.add(null);
      notifyListeners();
      throw Exception('Failed to save user');
    }
    _user = user;
    _streamController.add(user);
    notifyListeners();
    return result;
  }

  Future<bool> clearUser() async {
    bool result = await _storageService.remove("userKey");
    if (result) {
      _user = null;
      _streamController.add(null);
      notifyListeners();
      return result;
    } else {
      throw Exception('Failed to clear user');
    }
  }

  Future<void> startUpCheck() async {
    try {
      String? userData = _storageService.getString("userKey");
      if (userData != null) {
        _user = User.fromMap(jsonDecode(userData));
        _streamController.add(_user);
        notifyListeners();
      } else {
        _streamController.add(null);
        notifyListeners();
      }
    } catch (e) {
      Exception(e);
    }
  }
}
