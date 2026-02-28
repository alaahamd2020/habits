import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _languageKey = 'language_code';
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get languageCode {
    return _prefs?.getString(_languageKey) ?? 'en';
  }

  static Future<void> setLanguageCode(String code) async {
    await _prefs?.setString(_languageKey, code);
  }
}
