import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/formScreen.dart';
import 'package:recipe_app/screens/homeScreen.dart';
import 'package:recipe_app/screens/recipeDetailScreen.dart';
import 'package:recipe_app/screens/recipeListScreen.dart';
import 'package:recipe_app/screens/scaleRecipeScreen.dart';

enum FormMode {
  edit("Edit Recipe"),
  create("Add a new item");

  final String formAppBarTitle;
  const FormMode(this.formAppBarTitle);
}

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key, required this.recipeList});

  final List<Recipe> recipeList;

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  late List<Recipe> currentRecipeList;

  int _selectedIndex = 0;

  final List<int> favoriteRecipes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentRecipeList = widget.recipeList;
    checkFavorite();
  }

  // Method to handle BottomNavigationBar item taps
  void _onItemTapped(int? index) {
    if (index != null) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _setRecipeFavorite(int index) {
    setState(() {
      currentRecipeList[index].isFavorite = !currentRecipeList[index].isFavorite;
      currentRecipeList[index].addFavorite(favoriteRecipes, index);
    });
  }

  void checkFavorite() {
    for (var i = 0; i < currentRecipeList.length; i++) {
      if (currentRecipeList[i].isFavorite == true) {
        favoriteRecipes.add(i);
      }
    }
  }

  void toRecipeDetail(int index, Recipe recipe) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RecipeDetail(
        index: index,
        recipe: recipe,
        onEditTap: toRecipeForm,
        onFavoriteToggle: _setRecipeFavorite,
      ),
    ));
  }

  Future<void> toRecipeForm(Recipe? recipe, FormMode mode) async {
    if (!context.mounted) {
      return;
    }

    final result = await Navigator.of(context).push<Recipe?>(
      MaterialPageRoute(
        builder: (context) => RecipeForm(
          screenMode: mode,
          recipe: recipe,
        ),
      ),
    );

    if (!context.mounted || result == null) {
      return;
    }

    setState(() {
      if (mode == FormMode.edit) {
        final index = currentRecipeList.indexWhere((i) => i.id == recipe!.id);
        if (index != -1) {
          currentRecipeList[index] = result;
        }
      } else if (mode == FormMode.create) {
        currentRecipeList.add(result);
      }
    });
  }

  void deleteRecipe(Recipe recipe) {
    setState(() {
      currentRecipeList.remove(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final Orientation screenOrientation = MediaQuery.of(context).orientation;
    const Color bgColor = Color(0xFFFFFFFF);

    final List<Widget> _pages = [
      HomeScreen(
        bgColor: bgColor,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        screenOrientation: screenOrientation,
        recipes: currentRecipeList,
        onCardTap: toRecipeDetail,
      ),
      ScaleRecipe(
        bgColor: bgColor,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        screenOrientation: screenOrientation,
        recipes: currentRecipeList,
      ),
      RecipeList(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        bgColor: bgColor,
        recipes: currentRecipeList,
        favoriteRecipes: favoriteRecipes,
        onFavoriteToggle: _setRecipeFavorite,
        onRecipeCardTap: toRecipeDetail,
        onAddTap: toRecipeForm,
        onRemovedTap: deleteRecipe,
      ),
    ];

    print(screenWidth);
    print(screenHeight);
    print(screenOrientation);

    bool showBottomNavBar =
        _selectedIndex < _pages.length; // Hide on specific screens

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: showBottomNavBar
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.scale),
                  label: 'Scale Recipe',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Recipe List',
                ),
              ],
            )
          : null, // No BottomNavigationBar for the form screen
    );
  }
}
