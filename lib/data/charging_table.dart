import '../models/charging_point.dart';

/// Approximate remaining charging time (in hours) needed to reach a full
/// charge, indexed by the current battery percentage.
///
/// When the current percentage does not exactly match an entry,
/// `BatteryCalculator.chargingHours` picks the closest one by absolute
/// difference. Battery levels at or above 90% do not need charging at all.
const List<ChargingPoint> chargingTable = [
  ChargingPoint(percent: 85, hours: 4.0),
  ChargingPoint(percent: 80, hours: 4.5),
  ChargingPoint(percent: 70, hours: 5.0),
  ChargingPoint(percent: 60, hours: 5.5),
  ChargingPoint(percent: 50, hours: 6.0),
  ChargingPoint(percent: 40, hours: 7.0),
  ChargingPoint(percent: 30, hours: 7.5),
  ChargingPoint(percent: 25, hours: 8.0),
  ChargingPoint(percent: 20, hours: 8.5),
  ChargingPoint(percent: 15, hours: 9.0),
  ChargingPoint(percent: 10, hours: 9.5),
  ChargingPoint(percent: 5, hours: 10.0),
];
