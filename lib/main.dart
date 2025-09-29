import 'package:flutter/material.dart';
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: const FoodComponentsSearchBar()),
                  ThemeHandlerButton(),
                ],
              ),
              const HintTextCard(),
              const ProductsComponentsKind(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

class FoodComponentsSearchBar extends StatelessWidget {
  const FoodComponentsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          autoFocus: false,
          leading: Icon(Icons.search),
          hintText: 'Поиск по компонентам...',
          trailing: [
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {},
              tooltip: 'История поиска',
            ),
          ],
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return [
          ListTile(
            title: Text('Hello'),
            onTap: () {
              controller.closeView('Hello');
            },
          ),
        ];
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
              child: Icon(Icons.lightbulb),
            ),
            Flexible(
              child: Text(
                'Текст с подсказкой о том, что можно сделать поиск, просмотреть категории товаров либо отсканировать баркод',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsComponentsKind extends StatelessWidget {
  const ProductsComponentsKind({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          // color: Colors.lightGreenAccent,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Халяль', style: TextStyle(fontSize: 24)),
                Text('Компоненты, дозволенные для употребления в пищу'),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                // color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Машбух', style: TextStyle(fontSize: 24)),
                      Text('Компоненты, сомнительные для употребления в пищу'),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Card(
                // color: Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Харам', style: TextStyle(fontSize: 24)),
                      Text('Компоненты, запретные для употребления в пищу'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
