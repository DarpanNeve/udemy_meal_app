import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal, required this.onToggleFavourite});

  final Meal meal;
  final void Function (Meal meal)onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.00),
            child: IconButton(
              onPressed: () {
                onToggleFavourite(meal);
              },
              icon: const Icon(Icons.star_border),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final i in meal.ingredients) (Text(i)),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final step in meal.steps) (Text(step)),
            ],
          ),
        ),
      ),
    );
  }
}
