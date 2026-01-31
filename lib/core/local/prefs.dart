
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _sp;

  static Future<void> init() async => _sp = await SharedPreferences.getInstance();

  // Int operations
  static int getInt(String key, [int def = 0]) => _sp.getInt(key) ?? def;
  static Future<bool> setInt(String key, int value) => _sp.setInt(key, value);
  static Future<bool> removeInt(String key) => _sp.remove(key);

  // String operations
  static String getString(String key, [String def = '']) => _sp.getString(key) ?? def;
  static Future<bool> setString(String key, String value) => _sp.setString(key, value);
  static Future<bool> removeString(String key) => _sp.remove(key);

  // Bool operations
  static bool getBool(String key, [bool def = false]) => _sp.getBool(key) ?? def;
  static Future<bool> setBool(String key, bool value) => _sp.setBool(key, value);
  static Future<bool> removeBool(String key) => _sp.remove(key);

  // Double operations
  static double getDouble(String key, [double def = 0.0]) => _sp.getDouble(key) ?? def;
  static Future<bool> setDouble(String key, double value) => _sp.setDouble(key, value);
  static Future<bool> removeDouble(String key) => _sp.remove(key);

  // StringList operations
  static List<String> getStringList(String key, [List<String> def = const []]) =>
      _sp.getStringList(key) ?? def;
  static Future<bool> setStringList(String key, List<String> value) =>
      _sp.setStringList(key, value);
  static Future<bool> removeStringList(String key) => _sp.remove(key);

  // General operations
  static bool containsKey(String key) => _sp.containsKey(key);
  static Future<bool> remove(String key) => _sp.remove(key);
  static Future<void> clear() => _sp.clear();
  static Set<String> getKeys() => _sp.getKeys();
}
