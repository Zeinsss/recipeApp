import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widgets/bottomNav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.bgColor,
    required this.screenWidth,
    required this.screenHeight,
    required this.screenOrientation,
    required this.recipes,
    required this.onCardTap,
  });

  final double screenWidth;
  final double screenHeight;
  final Orientation screenOrientation;
  final Color bgColor;
  final List<Recipe> recipes;
  final Function(int, Recipe) onCardTap;

  List<Recipe> randomRecipe(List<Recipe> recipe) {
    List<Recipe> randList = [];
    for (var i = 0; i < 5; i++) {
      randList.add(recipe[Random().nextInt(recipe.length)]);
    }
    return randList;
  }

  @override
  Widget build(BuildContext context) {
    final randRecipes = randomRecipe(recipes);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7FB069),
        title: const Text(
          'Recipe App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured Recipe Card
              Text(
                'Featured Recipe',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              FeaturedRecipeCard(
                    screenWidth: screenWidth,
                    onCardTap: onCardTap,
                    recipe: recipes[0],
                    screenHeight: screenHeight),

              const SizedBox(height: 24),

              // Random Recipes Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Random Recipes',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: randRecipes.length,
                  itemBuilder: (context, index) {
                    return RandomRecipesCard(
                      screenWidth: screenWidth,
                      onCardTap: onCardTap,
                      recipe: randRecipes[index],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedRecipeCard extends StatelessWidget {
  const FeaturedRecipeCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onCardTap,
    required this.recipe,
  });

  final double screenWidth;
  final double screenHeight;
  final Function(int, Recipe) onCardTap;
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => onCardTap(0, recipe),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                'assets/food/slow-cooked-lamb.jpg',
                width: double.infinity,
                height: screenHeight * 0.25,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Favorite
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Slow Cooked Lamb',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Recipe Info
                  Row(
                    children: [
                      _buildInfoChip(Icons.timer, "${recipe.totalTime.toString()} mn"),
                      const SizedBox(width: 12),
                      _buildInfoChip(Icons.restaurant, '${recipe.servings} servings'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class RandomRecipesCard extends StatelessWidget {
  const RandomRecipesCard({
    super.key,
    required this.screenWidth,
    required this.onCardTap,
    required this.recipe,
    required this.index,
  });

  final int index;
  final double screenWidth;
  final Function(int, Recipe) onCardTap;
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 16,
        left: index == 0 ? 0 : 0,
      ),
      child: SizedBox(
        width: screenWidth * 0.4,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () => onCardTap(index, recipe),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recipe Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    recipe.imagePath,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.timer, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '20 min',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
