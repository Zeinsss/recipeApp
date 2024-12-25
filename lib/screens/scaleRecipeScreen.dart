import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widgets/bottomNav.dart';

class ScaleRecipe extends StatefulWidget {
  const ScaleRecipe({
    super.key,
    required this.bgColor,
    required this.screenWidth,
    required this.screenHeight,
    required this.screenOrientation, required this.recipes,
  });

  final double screenWidth;
  final double screenHeight;
  final Orientation screenOrientation;
  final Color bgColor;
  final List<Recipe> recipes;

  @override
  State<ScaleRecipe> createState() => _ScaleRecipeState();
}

class _ScaleRecipeState extends State<ScaleRecipe> {
  Recipe? selectedRecipe;
  int targetServings = 1;

  String scaleIngredient(String unit, double scale) {
    final RegExp numberPattern = RegExp(r'(\d*\.?\d+)');
    final match = numberPattern.firstMatch(unit);
    
    if (match == null) return unit;
    
    final number = double.parse(match.group(1)!);
    final scaledNumber = (number * scale).toStringAsFixed(1);
    return unit.replaceFirst(numberPattern, scaledNumber);
  }

  @override
  void initState() {
    super.initState();
    if (widget.recipes.isNotEmpty) {
      selectedRecipe = widget.recipes[0];
      targetServings = widget.recipes[0].servings;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7FB069),
        title: const Text('Recipe Scaler', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<Recipe>(
              value: selectedRecipe,
              decoration: const InputDecoration(
                labelText: 'Select Recipe',
                border: OutlineInputBorder(),
              ),
              items: widget.recipes.map((Recipe recipe) {
                return DropdownMenuItem(
                  value: recipe,
                  child: Text(recipe.title),
                );
              }).toList(),
              onChanged: (Recipe? value) {
                setState(() {
                  selectedRecipe = value;
                  targetServings = value?.servings ?? 1;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Servings: '),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    initialValue: targetServings.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        targetServings = int.tryParse(value) ?? targetServings;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (selectedRecipe != null) ...[
              const Text(
                'Scaled Ingredients:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedRecipe!.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = selectedRecipe!.ingredients.toList()[index];
                    final scale = targetServings / selectedRecipe!.servings;
                    final scaledUnit = scaleIngredient(ingredient.unit, scale);
                    
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(ingredient.name),
                            ),
                            Expanded(
                              child: Text(ingredient.unit),
                            ),
                            Expanded(
                              child: Text('→ $scaledUnit'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}