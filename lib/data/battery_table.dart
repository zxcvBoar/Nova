import '../models/battery_range.dart';

/// Voltage-to-percentage lookup table for a 60V (17S) e-scooter lithium
/// battery pack, based on typical resting-voltage discharge behavior.
///
/// Ordered from highest to lowest percentage. `BatteryCalculator` walks
/// this list top to bottom and returns the first range whose [minVoltage]
/// the reading satisfies, so the entries must remain sorted descending by
/// both [BatteryRange.percent] and [BatteryRange.minVoltage].
const List<BatteryRange> batteryTable = [
  BatteryRange(percent: 100, minVoltage: 66.7, maxVoltage: 68.0),
  BatteryRange(percent: 95, minVoltage: 66.0, maxVoltage: 66.6),
  BatteryRange(percent: 90, minVoltage: 65.3, maxVoltage: 65.9),
  BatteryRange(percent: 85, minVoltage: 64.6, maxVoltage: 65.2),
  BatteryRange(percent: 80, minVoltage: 63.9, maxVoltage: 64.5),
  BatteryRange(percent: 75, minVoltage: 63.1, maxVoltage: 63.8),
  BatteryRange(percent: 70, minVoltage: 62.4, maxVoltage: 63.0),
  BatteryRange(percent: 65, minVoltage: 61.7, maxVoltage: 62.3),
  BatteryRange(percent: 60, minVoltage: 61.0, maxVoltage: 61.6),
  BatteryRange(percent: 55, minVoltage: 60.3, maxVoltage: 60.9),
  BatteryRange(percent: 50, minVoltage: 59.6, maxVoltage: 60.2),
  BatteryRange(percent: 45, minVoltage: 58.9, maxVoltage: 59.5),
  BatteryRange(percent: 40, minVoltage: 58.2, maxVoltage: 58.8),
  BatteryRange(percent: 35, minVoltage: 57.4, maxVoltage: 58.1),
  BatteryRange(percent: 30, minVoltage: 56.7, maxVoltage: 57.3),
  BatteryRange(percent: 25, minVoltage: 56.0, maxVoltage: 56.6),
  BatteryRange(percent: 20, minVoltage: 55.3, maxVoltage: 55.9),
  BatteryRange(percent: 15, minVoltage: 54.6, maxVoltage: 55.2),
  BatteryRange(percent: 10, minVoltage: 53.9, maxVoltage: 54.5),
  BatteryRange(percent: 5, minVoltage: 53.2, maxVoltage: 53.8),
  BatteryRange(percent: 0, minVoltage: 52.5, maxVoltage: 53.1),
];
