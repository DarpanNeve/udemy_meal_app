import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';

import '../models/meal.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, required, this.title, required this.meals, required this.onToggleFavourite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(meal: meals[index],onToggleFavourite: onToggleFavourite,);
      },
      itemCount: meals.length,
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          children: [
            Text(
              'No meals found',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'try another filter',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            )
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
