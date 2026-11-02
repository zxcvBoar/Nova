/// Represents a single row of the voltage-to-percentage lookup table.
///
/// [minVoltage] and [maxVoltage] are kept mainly for human-readable display
/// (e.g. on the Info screen). The actual lookup performed by
/// `BatteryCalculator` only relies on [minVoltage] as a threshold, which
/// avoids gaps for voltages that fall between two published boundaries.
class BatteryRange {
  final int percent;
  final double minVoltage;
  final double maxVoltage;

  const BatteryRange({
    required this.percent,
    required this.minVoltage,
    required this.maxVoltage,
  });
}
