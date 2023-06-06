import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static Future<Object?> get<T>(String key, T defaultValue) async {
    var prefs = await SharedPreferences.getInstance();

    try {
      Object? value = prefs.get(key);
      if (value == null) {
        return defaultValue;
      }
      return value;
    } catch (error) {
      return defaultValue;
    }
  }

  static Future<bool> putInt(String key, int value) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<bool> putString(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> putDouble(String key, double value) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<bool> putBool(String key, bool value) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> putListString(String key, List<String> value) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  static Future<bool> clear(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> clearAll() async {
    var prefs = await SharedPreferences.getInstance();
    final result = await prefs.clear();
    return result;
  }
}
