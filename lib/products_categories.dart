import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ProductsComponentsKind extends StatelessWidget {
  const ProductsComponentsKind({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Халяль', style: TextStyle(fontSize: 24)),
                    SizedBox(width: 5),
                    Icon(Symbols.verified_user, color: Colors.lightGreen),
                  ],
                ),
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
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Машбух',
                            style: TextStyle(
                              fontSize: 24,
                              // color: Theme.of(context).colorScheme.errorContainer,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Symbols.shield_question,
                            color: Colors.orangeAccent,
                          ),
                        ],
                      ),
                      Text(
                        'Компоненты, сомнительные для употребления в пищу',
                        style: TextStyle(
                          // color: Theme.of(context).colorScheme.errorContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Card(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Харам', style: TextStyle(fontSize: 24)),
                          SizedBox(width: 5),
                          Icon(Symbols.gpp_bad, color: Colors.redAccent),
                        ],
                      ),
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
