import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService? _instance;
  final SharedPreferences _prefs;

  StorageService._(this._prefs);

  static Future<StorageService> initialize() async {
    _instance ??= StorageService._(await SharedPreferences.getInstance());
    return _instance!;
  }

  static StorageService get instance {
    if (_instance == null) {
      throw Exception('StorageService is not initialized');
    }
    return _instance!;
  }

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> remove(String key) => _prefs.remove(key);
}
