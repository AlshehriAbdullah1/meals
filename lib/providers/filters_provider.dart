import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegatarian }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegatarian: false,
        });
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state.cast()[filter] = isActive;
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final aciveFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (aciveFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (aciveFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (aciveFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (aciveFilters[Filter.vegatarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
