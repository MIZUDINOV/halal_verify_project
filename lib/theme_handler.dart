import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeHandlerProvider extends ChangeNotifier {
  static const String _key = 'theme_mode';
  final SharedPreferences prefs;
  ThemeMode _themeMode;

  ThemeHandlerProvider(this.prefs)
    : _themeMode = ThemeMode.values[prefs.getInt(_key) ?? 0];

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    prefs.setInt(_key, mode.index);
    notifyListeners();
  }
}

class ThemeHandlerButton extends StatefulWidget {
  const ThemeHandlerButton({super.key});

  @override
  State<ThemeHandlerButton> createState() => _ThemeHandlerButtonState();
}

class _ThemeHandlerButtonState extends State<ThemeHandlerButton> {
  Icon _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return const Icon(Icons.light_mode_outlined);
      case ThemeMode.dark:
        return const Icon(Icons.dark_mode_outlined);
      case ThemeMode.system:
        return const Icon(Icons.brightness_auto);
    }
  }

  String _getTooltip(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Светлая тема';
      case ThemeMode.dark:
        return 'Тёмная тема';
      case ThemeMode.system:
        return 'Системная тема';
    }
  }

  void _cycleThemeMode(ThemeHandlerProvider provider) {
    switch (provider.themeMode) {
      case ThemeMode.system:
        provider.setThemeMode(ThemeMode.light);
        break;
      case ThemeMode.light:
        provider.setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        provider.setThemeMode(ThemeMode.system);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeHandlerProvider>(
      builder: (context, themeProvider, child) {
        return IconButton(
          icon: _getThemeIcon(themeProvider.themeMode),
          onPressed: () => _cycleThemeMode(themeProvider),
          tooltip: _getTooltip(themeProvider.themeMode),
        );
      },
    );
  }
}
