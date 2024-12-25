import 'dart:math';

import 'package:recipe_app/models/ingredient.dart';
import 'package:uuid/uuid.dart';

class Recipe {
  late final String id;
  final String title;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final String category;
  final int prepTime;
  final int cookTime;
  final int servings;
  final String imagePath;
  bool isFavorite;

  Recipe({
    required this.title,
    required this.ingredients,
    required this.steps,
    required this.category,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.imagePath,
    this.isFavorite = false,
  }) : id = const Uuid().v4();

  // Calculate total time
  int get totalTime => prepTime + cookTime;

  void addFavorite(List<int> favoriteRecipes, int index) {
    if (favoriteRecipes.contains(index)) {
        favoriteRecipes.remove(index);
      } else {
        favoriteRecipes.add(index);
      }
  }

  @override
  String toString() {
    return 'Recipe: $title, Category: $category, Prep Time: $prepTime mins, Cook Time: $cookTime mins, Servings: $servings, Favorite: $isFavorite, Ingredients Count: ${ingredients}';
  } 
}
