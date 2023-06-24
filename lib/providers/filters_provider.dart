import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegatarian }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super({Filter.glutenFree:false,Filter.lactoseFree:false,Filter.vegan:false,Filter.vegatarian:false});
  
}

final filtersProvider = StateNotifierProvider((ref) => null);
