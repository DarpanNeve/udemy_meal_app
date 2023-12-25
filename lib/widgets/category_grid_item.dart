import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';

import '../models/meal.dart';
import '../screens/meals.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category, required this.availableMeals});

  final Category category;
final List <Meal> availableMeals;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final filteredMeals = availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MealScreen(
              title: category.title,
              meals: filteredMeals,
            ),
          ),
        ); // new
      },
      splashColor: Theme.of(context).colorScheme.onBackground,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [category.color.withOpacity(0.7), category.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
