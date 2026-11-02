/// A single reference point in the charging-time chart: at [percent]
/// battery charge, roughly [hours] are needed to reach a full charge.
class ChargingPoint {
  final int percent;
  final double hours;

  const ChargingPoint({
    required this.percent,
    required this.hours,
  });
}
