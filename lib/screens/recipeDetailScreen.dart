import 'package:flutter/material.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipeApp.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({
    super.key,
    required this.recipe,
    required this.onEditTap, required this.onFavoriteToggle, required this.index,
  });

  final int index;
  final Recipe recipe;
  final Future<void> Function(Recipe?, FormMode) onEditTap;
  final Function(int) onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7FB069),
        actions: [
          IconButton(
              onPressed: () => onEditTap(recipe, FormMode.edit),
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )
          ),
          IconButton(
            icon: Icon(
              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => onFavoriteToggle(index),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(recipe.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Recipe Overview
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipe.title,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildDetailChip(
                          icon: Icons.fastfood,
                          label: 'Category',
                          value: recipe.category),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  // Recipe Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailChip(
                        icon: Icons.timer,
                        label: 'Prep',
                        value: '${recipe.prepTime} mins',
                      ),
                      _buildDetailChip(
                        icon: Icons.fireplace_outlined,
                        label: 'Cook',
                        value: '${recipe.cookTime} mins',
                      ),
                      _buildDetailChip(
                        icon: Icons.people,
                        label: 'Serves',
                        value: '${recipe.servings}',
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Ingredients Section
                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  ...recipe.ingredients.map((ingredient) => ListTile(
                        leading: _getIngredientIcon(ingredient.category),
                        title: Text(ingredient.name),
                        trailing: Text(ingredient.unit),
                      )),

                  const SizedBox(height: 16),

                  // Steps Section
                  Text(
                    'Preparation Steps',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  ...recipe.steps.asMap().entries.map((entry) => ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            '${entry.key + 1}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(entry.value),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIngredientIcon(IngredientCategory category) {
    switch (category) {
      case IngredientCategory.dairy:
        return const Icon(Icons.local_drink);
      case IngredientCategory.vegetable:
        return const Icon(Icons.grass, color: Colors.green);
      case IngredientCategory.meat:
        return const Icon(Icons.set_meal, color: Colors.red);
      case IngredientCategory.fat:
        return const Icon(Icons.water_drop, color: Colors.yellow);
      case IngredientCategory.herb:
        return Icon(Icons.spa, color: Colors.green.shade300);
      case IngredientCategory.spice:
        return const Icon(Icons.fireplace, color: Colors.orange);
      case IngredientCategory.fruit:
        return const Icon(Icons.apple, color: Colors.red);
      case IngredientCategory.grain:
        return const Icon(Icons.grain, color: Colors.brown);
      case IngredientCategory.other:
      default:
        return const Icon(Icons.help_outline, color: Colors.grey);
    }
  }

  Widget _buildDetailChip({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
