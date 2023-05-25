import 'package:shared_preferences/shared_preferences.dart';


class SharePreferencesPlugin {

  static Future<SharedPreferences> _getPrefs() {
    return SharedPreferences.getInstance();
  }


  static Future<void> setBool( String key, bool value ) async {
    final prefs = await _getPrefs();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool( String key ) async {
    final prefs = await _getPrefs();
    return prefs.getBool(key);
  }


}