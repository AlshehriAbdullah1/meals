import "package:riverpod/riverpod.dart";
import 'package:meals/models/meal.dart';
import 'package:flutter/material.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);
  bool toggleMealFavoriteStatus(Meal meal) {
    final isExist = isFav(meal);
    if (isExist) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  bool isFav(Meal meal) {
    return state.contains(meal);
  }

  // Icon favoriteIcon(Meal meal) {
  //   return Icon();
  // }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
