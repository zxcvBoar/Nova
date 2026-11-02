import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around [SharedPreferences] that centralizes every storage
/// key used across the app, so the rest of the codebase never touches raw
/// string keys directly.
class PreferencesService {
  static const _keyDarkMode = 'nova_dark_mode';
  static const _keyMaxRange = 'nova_max_range_km';
  static const _keyLastVoltage = 'nova_last_voltage';

  static const double defaultMaxRangeKm = 25.0;

  Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDarkMode) ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, value);
  }

  Future<double> getMaxRange() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyMaxRange) ?? defaultMaxRangeKm;
  }

  Future<void> setMaxRange(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyMaxRange, value);
  }

  Future<double?> getLastVoltage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyLastVoltage);
  }

  Future<void> setLastVoltage(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyLastVoltage, value);
  }
}
