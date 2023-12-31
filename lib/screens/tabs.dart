import 'package:flutter/material.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'meals') {
    } else if (identifier == 'filters') {
      await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const FiltersScreen();
      }));
    }
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
    final _avaiableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
      avaliableMeals: _avaiableMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favoriteMeal = ref.watch(favoriteMealProvider);
      activePage = MealsScreen(
        meals: favoriteMeal,
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
