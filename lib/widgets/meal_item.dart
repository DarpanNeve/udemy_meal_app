import 'package:flutter/material.dart';
import 'package:meal_app/screens/meat_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';
import 'meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => MealDetailsScreen(meal: meal),
            ),
          );
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MealIteTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        MealIteTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        MealIteTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
