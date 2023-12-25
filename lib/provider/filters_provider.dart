import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import 'meal_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void toggleFilter(Filter filter) {
    state = {
      ...state,
      filter: !state[filter]!,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealProvider = Provider<List<Meal>>((ref) {
  final filters = ref.watch(filtersProvider);
  final meals = ref.watch(mealProvider);
  return meals.where((meal) {
    if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
