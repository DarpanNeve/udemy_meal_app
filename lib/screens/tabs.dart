import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';

import '../models/meal.dart';
import '../provider/favourite_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPage = 0;
  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };


  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      final result = await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(selectedFilters: _selectedFilters,),
        ),
      );
      setState(() {
        _selectedFilters = result ?? _selectedFilters;
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider);
    final availableMeals = meals.where((element) {
      if (_selectedFilters[Filter.glutenFree]! && !element.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !element.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !element.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen( availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";
    if (_selectedPage == 1) {
      final favouriteMeals = ref.watch(favouriteMealProvider);
      activePage = MealScreen(
        meals: favouriteMeals,
      );
      activePageTitle = 'Favourite';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favourite"),
        ],
      ),
    );
  }
}
