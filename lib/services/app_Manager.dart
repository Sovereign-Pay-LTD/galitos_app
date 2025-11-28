
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  // -------- Singleton setup --------
  AppManager._internal();
  static final AppManager _instance = AppManager._internal();
  factory AppManager() => _instance;

  // -------- App State Variables --------
  String ipAddress = "";
  bool debug = true;
  bool isCurrencyConfig = true;

  // -------- Keys for SharedPreferences --------
  static const String _ipKey = "ip_address";
  static const String _debugKey = "debug_mode";

  // -------- Load saved values when app starts --------
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    ipAddress = prefs.getString(_ipKey) ?? "";
    debug = prefs.getBool(_debugKey) ?? false;


  }

  Future<String> getIPAddress() async {
    final prefs = await SharedPreferences.getInstance();
    ipAddress = prefs.getString(_ipKey) ?? "";
    return ipAddress;

  }
  Future<bool> getDebug() async {
    final prefs = await SharedPreferences.getInstance();
    debug = prefs.getBool(_debugKey) ?? true;
    return debug;


  }
  // -------- Update IP Address --------
  Future<void> setIpAddress(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_ipKey, value);

  }

  Future<void> setCurrencyConfig(bool value) async {
   isCurrencyConfig =value;
  }
  // -------- Update Debug Mode --------
  Future<void> setDebug(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_debugKey, value);
    print(value.toString());
  }
}
