import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class FloatingNavbar extends StatelessWidget {
  const FloatingNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: NavigationBar(
          destinations: <Widget>[
            NavigationDestination(
              icon: Icon(Symbols.dashboard),
              label: 'Главная',
            ),
            IconButton(
              iconSize: 55,
              tooltip: 'Сканировать',
              onPressed: () {},
              icon: Icon(
                Symbols.barcode_scanner,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            NavigationDestination(
              icon: Icon(Symbols.history_2),
              label: 'История',
            ),
          ],
          elevation: 0,
        ),
      ),
    );
  }
}
