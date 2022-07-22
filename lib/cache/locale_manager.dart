import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  static final LocaleManager _instance = LocaleManager._init();

  SharedPreferences? _preferences;
  static LocaleManager get instance => _instance;

  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static Future prefrencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  Future<void> clearAllSaveFirst() async {
    if (_preferences != null) {
      await _preferences!.clear();
      await setBoolValue("is_first_app", true);
    }
  }

  Future<void> setStringValue(String key, String value) async {
    await _preferences!.setString(key.toString(), value);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await _preferences!.setBool(key.toString(), value);
  }

  String getStringValue(String key) =>
      _preferences!.getString(key.toString()) ?? '';

  bool getBoolValue(String key) =>
      _preferences!.getBool(key.toString()) ?? false;
}
