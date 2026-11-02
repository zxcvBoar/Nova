import 'package:flutter/material.dart';
import '../data/battery_table.dart';
import '../data/charging_table.dart';

/// Explains how the voltage-based battery estimation works and shows the
/// full reference tables used by `BatteryCalculator`.
class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('How It Works')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const _SectionCard(
              title: 'Voltage-Based Estimation',
              icon: Icons.bolt,
              child: Text(
                'A 60V e-scooter typically uses a 17-cell lithium battery '
                'pack with a resting full-charge voltage around 66.7V and '
                'a low-charge voltage near 52.5V.\n\n'
                'As the battery discharges, its resting (no-load) voltage '
                'drops in a fairly predictable curve. By comparing your '
                'measured voltage against a reference discharge table, the '
                'app estimates the approximate remaining charge '
                'percentage.\n\n'
                'For the most accurate reading, measure the voltage after '
                'the scooter has been resting — not riding or charging — '
                'for at least a few minutes.',
                style: TextStyle(height: 1.5, fontSize: 15),
              ),
            ),
            const SizedBox(height: 16),
            _SectionCard(
              title: 'Reference Voltage Table',
              icon: Icons.table_chart,
              child: Column(
                children: [
                  for (final range in batteryTable)
                    _TableRow(
                      left: '${range.percent}%',
                      right: range.percent == 100
                          ? '${range.minVoltage.toStringAsFixed(1)}V +'
                          : '${range.minVoltage.toStringAsFixed(1)} - '
                              '${range.maxVoltage.toStringAsFixed(1)}V',
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionCard(
              title: 'Charging Time Estimation',
              icon: Icons.ev_station,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Estimated time remaining to reach a full charge, '
                      'based on your current battery percentage. If your '
                      'percentage does not exactly match an entry, the '
                      'closest known value is used. Batteries at 90% or '
                      'above do not need charging.',
                      style: TextStyle(height: 1.5, fontSize: 15),
                    ),
                  ),
                  for (final point in chargingTable)
                    _TableRow(
                      left: '${point.percent}%',
                      right:
                          '${point.hours == point.hours.roundToDouble() ? point.hours.toStringAsFixed(0) : point.hours.toStringAsFixed(1)} Hours',
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const _SectionCard(
              title: 'Disclaimer',
              icon: Icons.warning,
              child: Text(
                'This estimation is based on typical discharge curves and '
                'is meant as a general guide only. Actual remaining '
                'capacity can vary with battery age, temperature, and '
                'load. Always follow your scooter manufacturer\'s official '
                'guidance.',
                style: TextStyle(height: 1.5, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final String left;
  final String right;

  const _TableRow({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(right),
        ],
      ),
    );
  }
}
