import 'package:flutter/material.dart';
import 'package:halal_verify/home.dart';
import 'package:halal_verify/theme/theme.dart';
import 'package:halal_verify/theme/util.dart';
import 'package:halal_verify/theme_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeHandlerProvider(prefs),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeHandlerProvider>(
      builder: (context, themeProvider, _) {
        final brightness = themeProvider.themeMode == ThemeMode.system
            ? View.of(context).platformDispatcher.platformBrightness
            : themeProvider.themeMode == ThemeMode.light
            ? Brightness.light
            : Brightness.dark;

        TextTheme textTheme = createTextTheme(
          context,
          "Roboto Flex",
          "Roboto Flex",
        );
        MaterialTheme theme = MaterialTheme(textTheme);

        return MaterialApp(
          title: 'Flutter Demo',
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
          home: const HomePage(),
        );
      },
    );
  }
}

class HintTextCard extends StatelessWidget {
  const HintTextCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: Icon(
                Icons.lightbulb,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            Flexible(
              child: Text(
                'Текст с подсказкой о том, что можно сделать поиск, просмотреть категории компонентов либо отсканировать баркод',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
