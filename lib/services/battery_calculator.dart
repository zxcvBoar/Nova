import '../data/battery_table.dart';
import '../data/charging_table.dart';
import '../models/battery_result.dart';

/// Pure, stateless helper that turns a raw voltage reading into a complete
/// [BatteryResult], using the reference tables in the `data` folder.
///
/// Keeping this logic separate from the widgets makes it trivial to unit
/// test and reuse (e.g. from a widget test or a future background check).
class BatteryCalculator {
  const BatteryCalculator._();

  /// Looks up the estimated state-of-charge percentage for a given
  /// resting voltage reading, based on [batteryTable].
  ///
  /// The table is ordered from highest to lowest percentage; the first
  /// range whose minimum voltage the reading satisfies is the match. This
  /// naturally covers voltages that fall between two published boundaries
  /// without leaving any gaps.
  static int percentageForVoltage(double voltage) {
    for (final range in batteryTable) {
      if (voltage >= range.minVoltage) {
        return range.percent;
      }
    }
    return 0;
  }

  /// Estimated remaining ride distance in kilometers, given the user's
  /// configured maximum range for a full (100%) charge.
  static double remainingDistance(int percentage, double maxRangeKm) {
    return (percentage / 100) * maxRangeKm;
  }

  /// Estimated hours remaining until a full charge, based on
  /// [chargingTable]. Returns null when the battery is already at 90% or
  /// above, since it does not need charging.
  static double? chargingHours(int percentage) {
    if (percentage >= 90) return null;

    var closestHours = chargingTable.first.hours;
    var bestDiff = (percentage - chargingTable.first.percent).abs();

    for (final point in chargingTable) {
      final diff = (percentage - point.percent).abs();
      if (diff < bestDiff) {
        bestDiff = diff;
        closestHours = point.hours;
      }
    }
    return closestHours;
  }

  /// Maps a percentage to a qualitative battery status bucket.
  static BatteryStatus statusForPercentage(int percentage) {
    if (percentage >= 90) return BatteryStatus.excellent;
    if (percentage >= 70) return BatteryStatus.good;
    if (percentage >= 50) return BatteryStatus.fair;
    if (percentage >= 30) return BatteryStatus.low;
    return BatteryStatus.critical;
  }

  /// Runs the full pipeline and returns a ready-to-display [BatteryResult].
  static BatteryResult calculate({
    required double voltage,
    required double maxRangeKm,
  }) {
    final percentage = percentageForVoltage(voltage);
    return BatteryResult(
      voltage: voltage,
      percentage: percentage,
      remainingDistanceKm: remainingDistance(percentage, maxRangeKm),
      chargingHours: chargingHours(percentage),
      status: statusForPercentage(percentage),
    );
  }
}
