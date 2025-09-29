import 'package:flutter/material.dart';
import 'package:halal_verify/float_navbar.dart';
import 'package:halal_verify/main.dart';
import 'package:halal_verify/products_categories.dart';
import 'package:halal_verify/search_bar.dart';
import 'package:halal_verify/theme_handler.dart';

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
              SizedBox(height: 20),
              const HintTextCard(),
              SizedBox(height: 100),
              const ProductsComponentsKind(),
            ],
          ),
        ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingNavbar(),
    );
  }
}
