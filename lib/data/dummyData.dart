import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';

List<Recipe> dummyRecipes = [
  Recipe(
    title: "Classic Spaghetti Bolognese",
    ingredients: [
      Ingredient(name: "Spaghetti", category: IngredientCategory.grain, unit: "200g"),
      Ingredient(name: "Ground Beef", category: IngredientCategory.meat, unit: "250g"),
      Ingredient(name: "Tomato Sauce", category: IngredientCategory.other, unit: "400ml"),
      Ingredient(name: "Onion", category: IngredientCategory.vegetable, unit: "1"),
      Ingredient(name: "Garlic Cloves", category: IngredientCategory.vegetable, unit: "2"),
      Ingredient(name: "Olive Oil", category: IngredientCategory.fat, unit: "2 tbsp"),
      Ingredient(name: "Salt", category: IngredientCategory.spice, unit: "to taste"),
      Ingredient(name: "Pepper", category: IngredientCategory.spice, unit: "to taste"),
      Ingredient(name: "Parmesan Cheese", category: IngredientCategory.dairy, unit: "50g"),
    ],
    steps: [
      "Boil water and cook spaghetti until al dente.",
      "Heat olive oil in a pan and sauté chopped onions and garlic.",
      "Add ground beef and cook until browned.",
      "Stir in tomato sauce and simmer for 15 minutes.",
      "Season with salt and pepper.",
      "Serve the sauce over spaghetti and top with grated Parmesan cheese.",
    ],
    category: "Main Course",
    prepTime: 15,
    cookTime: 30,
    servings: 4,
    imagePath: "assets/food/spaghetti_bolognese.jpg",
    isFavorite: true,
  ),
  Recipe(
    title: "Vegetable Stir Fry",
    ingredients: [
      Ingredient(name: "Broccoli", category: IngredientCategory.vegetable, unit: "150g"),
      Ingredient(name: "Carrots", category: IngredientCategory.vegetable, unit: "2"),
      Ingredient(name: "Bell Peppers", category: IngredientCategory.vegetable, unit: "1"),
      Ingredient(name: "Soy Sauce", category: IngredientCategory.other, unit: "3 tbsp"),
      Ingredient(name: "Ginger", category: IngredientCategory.herb, unit: "1 tbsp"),
      Ingredient(name: "Garlic Cloves", category: IngredientCategory.vegetable, unit: "2"),
      Ingredient(name: "Sesame Oil", category: IngredientCategory.fat, unit: "1 tbsp"),
    ],
    steps: [
      "Heat sesame oil in a wok.",
      "Add minced garlic and ginger, and sauté briefly.",
      "Toss in chopped vegetables and stir fry for 5-7 minutes.",
      "Add soy sauce and mix well.",
      "Serve hot as a side dish or with steamed rice.",
    ],
    category: "Side Dish",
    prepTime: 10,
    cookTime: 15,
    servings: 2,
    imagePath: "assets/food/spaghetti_bolognese.jpg",
    isFavorite: false,
  ),
  Recipe(
    title: "Chocolate Chip Cookies",
    ingredients: [
      Ingredient(name: "All-Purpose Flour", category: IngredientCategory.grain, unit: "250g"),
      Ingredient(name: "Butter", category: IngredientCategory.dairy, unit: "150g"),
      Ingredient(name: "Sugar", category: IngredientCategory.other, unit: "100g"),
      Ingredient(name: "Brown Sugar", category: IngredientCategory.other, unit: "100g"),
      Ingredient(name: "Eggs", category: IngredientCategory.other, unit: "2"),
      Ingredient(name: "Vanilla Extract", category: IngredientCategory.other, unit: "1 tsp"),
      Ingredient(name: "Chocolate Chips", category: IngredientCategory.other, unit: "200g"),
      Ingredient(name: "Baking Powder", category: IngredientCategory.other, unit: "1 tsp"),
      Ingredient(name: "Salt", category: IngredientCategory.spice, unit: "1/4 tsp"),
    ],
    steps: [
      "Preheat the oven to 180°C (350°F).",
      "Cream butter and sugars together until fluffy.",
      "Add eggs and vanilla extract, and mix well.",
      "Sift in flour, baking powder, and salt, and fold into the mixture.",
      "Stir in chocolate chips.",
      "Scoop dough onto a baking tray and bake for 10-12 minutes.",
      "Let cookies cool on a wire rack before serving.",
    ],
    category: "Dessert",
    prepTime: 20,
    cookTime: 12,
    servings: 24,
    imagePath: "assets/food/spaghetti_bolognese.jpg",
    isFavorite: true,
  ),
  Recipe(
    title: "Greek Salad",
    ingredients: [
      Ingredient(name: "Cucumber", category: IngredientCategory.vegetable, unit: "1"),
      Ingredient(name: "Tomatoes", category: IngredientCategory.vegetable, unit: "3"),
      Ingredient(name: "Red Onion", category: IngredientCategory.vegetable, unit: "1"),
      Ingredient(name: "Feta Cheese", category: IngredientCategory.dairy, unit: "100g"),
      Ingredient(name: "Olives", category: IngredientCategory.other, unit: "50g"),
      Ingredient(name: "Olive Oil", category: IngredientCategory.fat, unit: "2 tbsp"),
      Ingredient(name: "Oregano", category: IngredientCategory.herb, unit: "1 tsp"),
      Ingredient(name: "Salt", category: IngredientCategory.spice, unit: "to taste"),
      Ingredient(name: "Pepper", category: IngredientCategory.spice, unit: "to taste"),
    ],
    steps: [
      "Chop cucumber, tomatoes, and red onion into bite-sized pieces.",
      "Combine in a bowl and add olives and crumbled feta cheese.",
      "Drizzle with olive oil and sprinkle with oregano, salt, and pepper.",
      "Toss gently and serve fresh.",
    ],
    category: "Salad",
    prepTime: 10,
    cookTime: 0,
    servings: 2,
    imagePath: "assets/food/spaghetti_bolognese.jpg",
    isFavorite: false,
  ),
  
];