import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final Function(int) onFavoriteToggle;
  final VoidCallback onTap;
  final Function(Recipe) onRemovedTap;
  final int index; // Add index parameter

  const RecipeCard({
    super.key,
    required this.onFavoriteToggle,
    required this.onTap,
    required this.onRemovedTap,
    required this.recipe,
    required this.index, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  recipe.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      recipe.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => onRemovedTap(recipe),
                  ),
                  IconButton(
                    icon: Icon(
                      recipe.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: recipe.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => onFavoriteToggle(index), // Pass the index
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}