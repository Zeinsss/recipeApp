import 'package:recipe_app/models/ingredient.dart';

class Recipe {
  final int id;
  final String title;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final String category;
  final int prepTime;
  final int cookTime;
  final int servings;
  final String? imagePath;
  // final bool isFavorite;
  // final String? cuisine;
  // final int? difficultyLevel;
  // final List<String>? tags;

  Recipe(
    this.id,
    this.title,
    this.ingredients,
    this.steps,
    this.category,
    this.prepTime,
    this.cookTime,
    this.servings,
    this.imagePath,
    // this.isFavorite = false,
    // this.cuisine,
    // this.difficultyLevel,
    // this.tags,
  );

  void scaleRecipe() {

  }

  void createRecipe() {

  }

  void editRecipe() {

  }

  void deleteRecipe() {

  }

  void viewRecipe() {
    
  }
}
