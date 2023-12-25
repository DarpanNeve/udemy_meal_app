import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

final favouriteMealProvider =
    StateNotifierProvider<FavouriteMealNotifier, List<Meal>>(
        (ref) => FavouriteMealNotifier());

class FavouriteMealNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealNotifier() : super([]);

  bool toggleFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);
    if (mealIsFavourite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}


