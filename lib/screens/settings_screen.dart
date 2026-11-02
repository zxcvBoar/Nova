import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

/// Lets the user toggle Dark Mode and update the scooter's maximum range
/// per full charge (used to estimate remaining distance).
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _rangeController;

  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsProvider>();
    _rangeController = TextEditingController(
      text: _formatRange(settings.maxRange),
    );
  }

  @override
  void dispose() {
    _rangeController.dispose();
    super.dispose();
  }

  String _formatRange(double value) {
    final isWhole = value == value.roundToDouble();
    return isWhole ? value.toStringAsFixed(0) : value.toStringAsFixed(1);
  }

  void _saveRange(SettingsProvider settings) {
    final parsed = double.tryParse(_rangeController.text.trim());
    if (parsed == null || parsed <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid range in kilometers')),
      );
      return;
    }
    settings.setMaxRange(parsed);
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Maximum range updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                title: const Text('Dark Mode'),
                subtitle: const Text(
                  'Switch between light and dark app themes',
                ),
                secondary: const Icon(Icons.dark_mode),
                value: settings.isDarkMode,
                onChanged: settings.setDarkMode,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.route, color: theme.colorScheme.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Maximum Range',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Distance your scooter can travel on a full (100%) '
                      'charge. Update this if you discover your real-world '
                      'range is different — the default is 25 km.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _rangeController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Max Range (km)',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 58,
                          child: ElevatedButton(
                            onPressed: () => _saveRange(settings),
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
