import 'package:flutter/material.dart';

/// Small, centered credit line shown beneath the battery result card and
/// the battery-care reminders.
class FooterCredit extends StatelessWidget {
  const FooterCredit({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24, bottom: 4),
      child: Center(
        child: Text(
          '© Kim Dexter Diano',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
