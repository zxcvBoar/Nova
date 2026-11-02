import 'package:flutter/material.dart';

/// Static card listing the four battery-care reminders, always shown below
/// the result card once a check has been performed.
class ReminderList extends StatelessWidget {
  const ReminderList({super.key});

  static const List<_Reminder> _reminders = [
    _Reminder(
      icon: Icons.battery_alert,
      text: 'Avoid charging above 70% and avoid letting the battery go '
          'below 30% whenever possible.',
    ),
    _Reminder(
      icon: Icons.ac_unit,
      text: 'After riding, allow the battery to cool down for about 30 '
          'minutes before charging.',
    ),
    _Reminder(
      icon: Icons.hourglass_empty,
      text: 'After charging, let the battery rest for about 30 minutes '
          'before riding.',
    ),
    _Reminder(
      icon: Icons.schedule,
      text: 'Follow the recommended charging time.',
    ),
  ];

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
                Icon(Icons.info_outline, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Important Reminders',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            for (final reminder in _reminders)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      reminder.icon,
                      size: 18,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        reminder.text,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Reminder {
  final IconData icon;
  final String text;

  const _Reminder({required this.icon, required this.text});
}
