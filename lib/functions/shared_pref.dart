import 'dart:convert';

import 'package:just_todo/constants/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value == null) return null;
    return json.decode(value);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clean() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static showStored() async {
    final value = await SharedPref().read(PreferencesKeys.tasks);
    print("StoredValues -> $value");
  }
}
