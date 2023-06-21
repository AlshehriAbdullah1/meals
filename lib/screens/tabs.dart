import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.Vegatarian: false,
  Filter.lactoseFree: false,
  Filter.Vegan: false,
};

enum Filter { glutenFree, lactoseFree, Vegan, Vegatarian }

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'meals') {
    } else if (identifier == 'filters') {
      final result = await Navigator.of(context)
          .push<Map<Filter, bool>?>(MaterialPageRoute(builder: (ctx) {
        return const FiltersScreen();
      }));
      if (result != null) {
        setState(() {
          _selectedFilters = result;
        });
      } else {
        setState(() {
          _selectedFilters = kInitialFilters;
        });
      }
    }
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = isFavorite(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is not longer favorite!');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Meal has been added to favorite! ');
    }
  }

  bool isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  void _selectPage(int index) {
    if (_selectedPageIndex == index) {
    } else {
      setState(() {
        print('setting the index to $index');
        _selectedPageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _avaiableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.Vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.Vegatarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      isFavorite: isFavorite,
      avaliableMeals: _avaiableMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
        isFavorite: isFavorite,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('$activePageTitle'),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
        onTap: _selectPage,
      ),
    );
  }
}
