import 'package:flutter/material.dart';
import '../models/battery_result.dart';
import 'battery_icon_widget.dart';

/// Large result card displayed after the user taps "Check Battery".
///
/// Shows the animated percentage, a circular progress ring paired with a
/// battery glyph, the battery status chip, and the voltage / range /
/// charging-time details.
class ResultCard extends StatelessWidget {
  final BatteryResult result;

  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = result.statusColor;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Battery Percentage',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TweenAnimationBuilder<int>(
                        tween: IntTween(begin: 0, end: result.percentage),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Text(
                            '$value%',
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 92,
                  height: 92,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: 0,
                          end: result.percentage / 100,
                        ),
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return SizedBox(
                            width: 92,
                            height: 92,
                            child: CircularProgressIndicator(
                              value: value,
                              strokeWidth: 8,
                              backgroundColor: statusColor.withOpacity(0.15),
                              valueColor: AlwaysStoppedAnimation(statusColor),
                            ),
                          );
                        },
                      ),
                      BatteryIconWidget(
                        percentage: result.percentage,
                        color: statusColor,
                        width: 32,
                        height: 52,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.battery_full, size: 18, color: statusColor),
                    const SizedBox(width: 6),
                    Text(
                      'Battery Status: ${result.statusLabel}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Divider(height: 1, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 20),
            _InfoRow(
              icon: Icons.bolt,
              label: 'Voltage',
              value: '${result.voltage.toStringAsFixed(1)}V',
            ),
            const SizedBox(height: 14),
            _InfoRow(
              icon: Icons.route,
              label: 'Estimated Remaining Distance',
              value: '${result.remainingDistanceKm.toStringAsFixed(1)} km',
            ),
            const SizedBox(height: 14),
            _InfoRow(
              icon: Icons.ev_station,
              label: 'Charging Time',
              value: result.chargingTimeLabel,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: theme.textTheme.bodyMedium),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          textAlign: TextAlign.right,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
