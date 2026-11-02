import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/battery_result.dart';
import '../providers/settings_provider.dart';
import '../services/battery_calculator.dart';
import '../widgets/footer_credit.dart';
import '../widgets/reminder_list.dart';
import '../widgets/result_card.dart';
import 'about_screen.dart';
import 'info_screen.dart';
import 'settings_screen.dart';

/// The app's main and only top-level screen: voltage entry, the
/// "Check Battery" action, and the animated result once computed.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _voltageController = TextEditingController();

  BatteryResult? _result;
  bool _prefilledFromHistory = false;

  @override
  void dispose() {
    _voltageController.dispose();
    super.dispose();
  }

  void _checkBattery(SettingsProvider settings) {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    FocusScope.of(context).unfocus();

    final voltage = double.parse(_voltageController.text.trim());
    final result = BatteryCalculator.calculate(
      voltage: voltage,
      maxRangeKm: settings.maxRange,
    );

    // Persist the reading so it can be restored the next time the app
    // opens.
    settings.setLastVoltage(voltage);

    setState(() => _result = result);
  }

  String? _validateVoltage(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Please enter the battery voltage';
    }
    final parsed = double.tryParse(text);
    if (parsed == null) {
      return 'Enter a valid number';
    }
    if (parsed <= 0 || parsed > 100) {
      return 'Enter a realistic voltage (e.g. 45 - 70)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final theme = Theme.of(context);

    // Pre-fill the field with the last saved voltage exactly once, as soon
    // as SharedPreferences has finished loading.
    if (!_prefilledFromHistory && settings.isLoaded) {
      _prefilledFromHistory = true;
      final lastVoltage = settings.lastVoltage;
      if (lastVoltage != null) {
        _voltageController.text = lastVoltage.toStringAsFixed(1);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('NOVA'),
        actions: [
          IconButton(
            tooltip: 'How it works',
            icon: const Icon(Icons.help_outline),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const InfoScreen()),
            ),
          ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
          PopupMenuButton<String>(
            tooltip: 'More',
            onSelected: (value) {
              if (value == 'about') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'about', child: Text('About')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'NOVA',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Estimate battery level using voltage.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 28),
                TextFormField(
                  controller: _voltageController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Battery Voltage (V)',
                    hintText: 'e.g. 62.8',
                    prefixIcon: Icon(Icons.bolt),
                  ),
                  validator: _validateVoltage,
                  onFieldSubmitted: (_) => _checkBattery(settings),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 58,
                  child: ElevatedButton.icon(
                    onPressed: () => _checkBattery(settings),
                    icon: const Icon(Icons.search),
                    label: const Text('Check Battery'),
                  ),
                ),
                const SizedBox(height: 28),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    final scale = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    );
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: scale, child: child),
                    );
                  },
                  child: _result == null
                      ? const SizedBox.shrink(key: ValueKey('empty-result'))
                      : Column(
                          key: ValueKey(
                            '${_result!.voltage}-${_result!.percentage}',
                          ),
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ResultCard(result: _result!),
                            const SizedBox(height: 20),
                            const ReminderList(),
                            const FooterCredit(),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
