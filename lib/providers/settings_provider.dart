import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

/// App-wide settings and last-used values, persisted through
/// [PreferencesService] and exposed to the widget tree via `provider`.
///
/// Widgets that read these values with `context.watch<SettingsProvider>()`
/// automatically rebuild whenever a setting changes.
class SettingsProvider extends ChangeNotifier {
  final PreferencesService _prefsService;

  bool _isDarkMode = false;
  double _maxRange = PreferencesService.defaultMaxRangeKm;
  double? _lastVoltage;
  bool _isLoaded = false;

  SettingsProvider({PreferencesService? preferencesService})
      : _prefsService = preferencesService ?? PreferencesService() {
    _loadSettings();
  }

  bool get isDarkMode => _isDarkMode;
  double get maxRange => _maxRange;
  double? get lastVoltage => _lastVoltage;

  /// True once the persisted values have been read from disk. Useful to
  /// avoid overwriting a field with stale defaults before the real value
  /// has finished loading.
  bool get isLoaded => _isLoaded;

  Future<void> _loadSettings() async {
    _isDarkMode = await _prefsService.getDarkMode();
    _maxRange = await _prefsService.getMaxRange();
    _lastVoltage = await _prefsService.getLastVoltage();
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    notifyListeners();
    await _prefsService.setDarkMode(value);
  }

  Future<void> setMaxRange(double value) async {
    _maxRange = value;
    notifyListeners();
    await _prefsService.setMaxRange(value);
  }

  Future<void> setLastVoltage(double value) async {
    _lastVoltage = value;
    await _prefsService.setLastVoltage(value);
  }
}
