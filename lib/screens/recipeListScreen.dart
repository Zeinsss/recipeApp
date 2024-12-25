import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipeApp.dart';
import 'package:recipe_app/widgets/recipeCard.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({
    super.key,
    required this.screenWidth,
    required this.bgColor,
    required this.screenHeight,
    required this.recipes,
    required this.favoriteRecipes,
    required this.onFavoriteToggle,
    required this.onRecipeCardTap,
    required this.onRemovedTap, required this.onAddTap,
  });

  final double screenHeight;
  final double screenWidth;
  final Color bgColor;
  final List<Recipe> recipes;
  final List<int> favoriteRecipes;
  final Function(int) onFavoriteToggle;
  final Function(int, Recipe) onRecipeCardTap;
  final Function(Recipe) onRemovedTap;
  final Function(Recipe?, FormMode) onAddTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7FB069),
        title: const Text(
          'Recipe App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Tooltip(
            message: "New Recipe",
            child: IconButton(
              onPressed: () => onAddTap(null, FormMode.create),
              icon: const Icon(Icons.add),
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          width: screenWidth * 0.9,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 8,
              mainAxisSpacing: 4,
              childAspectRatio: 0.8, // Adjust aspect ratio for better fit
            ),
            itemCount: recipes.length, // Total number of items
            itemBuilder: (context, index) {
              return RecipeCard(
                index: index,
                recipe: recipes[index],
                onFavoriteToggle: (index) => onFavoriteToggle(index),
                onTap: () => onRecipeCardTap(index, recipes[index]),
                onRemovedTap: onRemovedTap,
              );
            },
          ),
        ),
      ),
    );
  }
}
