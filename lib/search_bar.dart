import 'package:flutter/material.dart';

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
