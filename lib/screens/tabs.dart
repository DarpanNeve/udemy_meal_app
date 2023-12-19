import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPage = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage=const CategoriesScreen();
    var activePageTitle="Categories";
    if(_selectedPage==1){
      activePage=const MealScreen( meals: []);
      activePageTitle='Favourite';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
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
