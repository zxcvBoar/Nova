import 'package:flutter/material.dart';

/// Qualitative health/status bucket derived from the battery percentage.
enum BatteryStatus { excellent, good, fair, low, critical }

/// The complete outcome of a single "Check Battery" calculation, ready to
/// be rendered by the UI.
class BatteryResult {
  final double voltage;
  final int percentage;
  final double remainingDistanceKm;

  /// Estimated hours remaining until a full charge. Null means the battery
  /// is already at 90% or above and does not need charging.
  final double? chargingHours;

  final BatteryStatus status;

  const BatteryResult({
    required this.voltage,
    required this.percentage,
    required this.remainingDistanceKm,
    required this.chargingHours,
    required this.status,
  });

  /// Human-readable label for [status].
  String get statusLabel {
    switch (status) {
      case BatteryStatus.excellent:
        return 'Excellent';
      case BatteryStatus.good:
        return 'Good';
      case BatteryStatus.fair:
        return 'Fair';
      case BatteryStatus.low:
        return 'Low';
      case BatteryStatus.critical:
        return 'Critical';
    }
  }

  /// Color used for the progress ring, battery icon, and status chip.
  /// Follows the green / orange / red rule:
  ///  - Green: 70% and above
  ///  - Orange: 30% to 69%
  ///  - Red: below 30%
  Color get statusColor {
    if (percentage >= 70) return const Color(0xFF2E7D32); // Green
    if (percentage >= 30) return const Color(0xFFEF6C00); // Orange
    return const Color(0xFFC62828); // Red
  }

  /// Human-readable charging time, e.g. "5 Hours" or "No charging needed".
  String get chargingTimeLabel {
    final hours = chargingHours;
    if (hours == null) return 'No charging needed';

    final isWholeNumber = hours == hours.roundToDouble();
    final formatted =
        isWholeNumber ? hours.toStringAsFixed(0) : hours.toStringAsFixed(1);
    final unit = hours == 1 ? 'Hour' : 'Hours';
    return '$formatted $unit';
  }
}
