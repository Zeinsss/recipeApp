import 'package:flutter/material.dart';
import 'package:recipe_app/data/dummyData.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipeApp.dart';
import 'package:path_provider/path_provider.dart';
import 'models/ingredient.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RecipeApp(recipeList: dummyRecipes),
  ));
}