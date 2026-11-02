# NOVA

A Flutter (Material 3) Android app that estimates the remaining battery
percentage of a 60V electric scooter from a single voltage reading, along
with estimated remaining range and charging time.

Made by **Kim Dexter Diano**.

## Features

- Startup splash screen with the NOVA brand mark and a "Made by Kim Dexter
  Diano" credit, fading smoothly into the Home screen
- Clean Material 3 UI with green accents and rounded cards
- Voltage → percentage lookup based on a 60V pack discharge table
- Estimated remaining ride distance (based on a configurable max range)
- Estimated charging time, using the closest match on the reference chart
- Color-coded status (green / orange / red) and battery health label
- Animated result card, animated percentage counter, circular progress ring
- Custom-painted battery icon that fills according to charge level
- A centered "© Kim Dexter Diano" credit shown beneath the result and
  battery-care reminders
- Persists the last-entered voltage and settings with `shared_preferences`
- Dark Mode toggle
- Settings screen to customize Maximum Range (default 25 km)
- About screen and an Info screen explaining the voltage estimation method

## Project structure

```
lib/
  main.dart                      # App entry point, theme setup, root widget (NovaApp)
  theme/
    app_theme.dart                # Material 3 light/dark theme definitions
  models/
    battery_range.dart            # Voltage-range table row model
    charging_point.dart           # Charging-time table row model
    battery_result.dart           # Full calculation result + display helpers
  data/
    battery_table.dart            # Voltage → percentage reference table
    charging_table.dart           # Percentage → charging time reference table
  services/
    battery_calculator.dart       # Pure calculation logic (unit-testable)
    preferences_service.dart      # SharedPreferences wrapper
  providers/
    settings_provider.dart        # App settings state (ChangeNotifier)
  screens/
    splash_screen.dart            # Startup splash: NOVA brand + startup credit
    home_screen.dart              # Main screen: input, check, results
    settings_screen.dart          # Dark mode + max range settings
    about_screen.dart             # About page
    info_screen.dart              # How-it-works + reference tables
  widgets/
    battery_icon_widget.dart      # Custom-painted battery glyph
    result_card.dart              # Animated result card
    reminder_list.dart            # Static battery-care reminders
    footer_credit.dart            # "© Kim Dexter Diano" footer
```

## Getting started

This is a complete, ready-to-open Flutter project targeting Android.

1. Make sure you have the latest stable [Flutter SDK](https://flutter.dev)
   installed (`flutter --version`).
2. Unzip this project and open it in your terminal or IDE.
3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run on a connected device or emulator:

   ```bash
   flutter run
   ```

5. Build a release APK:

   ```bash
   flutter build apk --release
   ```

### If Gradle/AGP versions don't match your local Flutter install

Android tooling (Gradle, the Android Gradle Plugin, Kotlin) evolves
quickly. The `android/` folder here uses a standard, modern configuration,
but if your installed Flutter SDK expects different versions, the safest
fix is to let Flutter regenerate the platform folder for you:

```bash
flutter create .
```

Run this **from the project root** — it only refreshes the `android/`
(and `ios/`) scaffolding to match your current Flutter version and will
not touch your `lib/` source code.

## How the estimation works

See the in-app **Info** screen (tap the ⓘ icon) for a full explanation and
the complete reference tables, or check `lib/services/battery_calculator.dart`
and `lib/data/` for the underlying logic and data.

**Note:** the voltage/percentage table models typical resting-voltage
behavior for a 60V pack and is meant as a general estimation guide, not a
precision instrument reading.

## Credits

NOVA was created by **Kim Dexter Diano**.
