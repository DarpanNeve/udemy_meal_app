import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavourite, required this.availableMeals});
  final void Function(Meal meal) onToggleFavourite;
final List<Meal> availableMeals;
  @override
  Widget build(BuildContext context) {
    return  GridView(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
          children: [
            for (final i in availableCategories)
              CategoryGridItem(category: i,onToggleFavourite: onToggleFavourite, availableMeals: availableMeals,)
          ],
        );
  }
}
