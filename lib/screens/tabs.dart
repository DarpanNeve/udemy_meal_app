import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPage = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter,bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(message),
      ),
    );
  }

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

  void toggleFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage("Meal is no longer Favourite");
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showInfoMessage("Meal is added to Favourite");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals=dummyMeals.where((element) {
      if(_selectedFilters[Filter.glutenFree]! && !element.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !element.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !element.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !element.isVegan){
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFavourite: toggleFavouriteStatus, availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";
    if (_selectedPage == 1) {
      activePage = MealScreen(
        meals: _favouriteMeals,
        onToggleFavourite: toggleFavouriteStatus,
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
