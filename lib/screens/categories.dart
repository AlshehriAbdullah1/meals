import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,required this.avaliableMeals});

  final List<Meal> avaliableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = avaliableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return MealsScreen(
          title: category.title,
          meals: filteredMeals,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: availableCategories
            .map((category) => CategoryGridItem(
                  category: category,
                  onSelectCategory: _selectCategory,
                ))
            .toList());
  }
}
