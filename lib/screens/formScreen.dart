import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/models/ingredient.dart';
import 'package:recipe_app/models/recipe.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:recipe_app/screens/homeScreen.dart';
import 'package:recipe_app/screens/recipeApp.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({super.key, this.recipe, required this.screenMode});

  final Recipe? recipe;
  final FormMode screenMode;

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  Recipe? currentGroceryItem;

  final _formKey = GlobalKey<FormState>();

  String _enteredTitle = '';

  int _enteredPrepTime = 0;

  int _enteredCookTime = 0;

  int _enteredServings = 0;

  final List<TextEditingController> _ingredientControllers = [
    TextEditingController()
  ];

  final List<TextEditingController> _stepControllers = [
    TextEditingController()
  ];

  final List<TextEditingController> _unitControllers = [
    TextEditingController()
  ];
  final List<IngredientCategory> _unitTypes = [IngredientCategory.dairy];

  late String _selectedCategory;

  String? _imagePath;

  // Favorite status
  bool _isFavorite = false;

  bool get validateNullRecipe => currentGroceryItem != null;

  final ImagePicker _picker = ImagePicker();

  File? _imageFile;

  final List<DropdownMenuItem<IngredientCategory>> ingredientCategoryItems =
      IngredientCategory.values.map((category) {
    return DropdownMenuItem(
      value: category,
      child: Text(category.name),
    );
  }).toList();

  @override
  void initState() {
    super.initState();
    currentGroceryItem = widget.recipe;
  }

  // Validators
  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a recipe title';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters long';
    }
    return null;
  }

  String? _validatePositiveNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    final number = int.tryParse(value.trim());
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number < 0) {
      return '$fieldName cannot be negative';
    }
    if (number > 1440) {
      // Max minutes in a day
      return '$fieldName seems unrealistically high';
    }
    return null;
  }

  String? _validateIngredient(String? value, int index) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter ingredient ${index + 1}';
    }
    if (value.trim().length < 2) {
      return 'Ingredient must be at least 2 characters long';
    }
    return null;
  }

  String? _validateStep(String? value, int index) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the steps ${index + 1}';
    }
    if (value.trim().length < 2) {
      return 'Step must be at least 2 characters long';
    }
    return null;
  }

  String? _validateUnit(String? value, int index) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the steps ${index + 1}';
    }
    if (value.trim().length < 2) {
      return 'Unit must be at least 2 characters long';
    }

    // Check if the unit is one of the allowed units
    String unit = value.trim().toLowerCase();
    if (!(unit.endsWith('ml') ||
        unit.endsWith('l') ||
        unit.endsWith('g') ||
        unit.endsWith('kg') ||
        unit.endsWith('tbsp') ||
        unit.endsWith('to taste') ||
        unit.endsWith(''))) {
      return 'Unit must be one of: ml, l, g, kg';
    }
    return null;
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        _imageFile = File(pickedFile.path);
      });
    }
  }

  _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final List<Ingredient> ingredientList = [];
      final List<String> stepList = [];

      for (var i = 0; i < _ingredientControllers.length; i++) {
        ingredientList.add(Ingredient(
          category: _unitTypes[i], // Dynamic category selection
          name: _ingredientControllers[i].text.trim(),
          unit: _unitControllers[i].text.trim(),
        ));
      }

      for (var step in _stepControllers) {
        stepList.add(step.text);
      }
      final recipe = Recipe(
          title: _enteredTitle,
          ingredients: ingredientList,
          steps: stepList,
          category: _selectedCategory,
          prepTime: _enteredPrepTime,
          cookTime: _enteredCookTime,
          servings: _enteredServings,
          imagePath: _imagePath ?? '');
      print(recipe);
      
      try {
        await _saveRecipe();
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipe saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save recipe: $e')),
        );
      }
      
      if(!mounted) return;

      Navigator.pop(context, recipe);
    }
  }

  @override
  void dispose() {
    for (var unit in _unitControllers) {
      unit.dispose();
    }
    for (var ingredient in _ingredientControllers) {
      ingredient.dispose();
    }
    for (var step in _stepControllers) {
      step.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7ce9a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7FB069),
        title: const Text('Add New Recipe'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Title Form Input
                TextFormField(
                  initialValue:
                      validateNullRecipe ? currentGroceryItem!.title : "",
                  decoration: const InputDecoration(
                    labelText: 'Recipe Title',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateTitle,
                  onSaved: (newValue) => _enteredTitle = newValue!,
                ),

                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ingredients',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _ingredientControllers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top row with ingredient input
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _ingredientControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Ingredient ${index + 1}',
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle,
                                        color: Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        _ingredientControllers
                                            .add(TextEditingController());
                                        _unitControllers
                                            .add(TextEditingController());
                                        _unitTypes
                                            .add(IngredientCategory.dairy);
                                      });
                                    },
                                  ),
                                  if (_ingredientControllers.length > 1)
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle,
                                          color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          _ingredientControllers
                                              .removeAt(index);
                                          _unitControllers.removeAt(index);
                                          _unitTypes.removeAt(index);
                                        });
                                      },
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Bottom row with category dropdown and unit input
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<
                                        IngredientCategory>(
                                      isDense: true,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _unitTypes[index],
                                      items: ingredientCategoryItems,
                                      onChanged: (value) {
                                        setState(() {
                                          _unitTypes[index] = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _unitControllers[index],
                                      decoration: InputDecoration(
                                        labelText: switch (_unitTypes[index]) {
                                          IngredientCategory.dairy =>
                                            "(g/kg, mL/L)",
                                          IngredientCategory.vegetable =>
                                            "(g/kg)",
                                          IngredientCategory.meat => "(g/kg)",
                                          IngredientCategory.fat => "(tbsp)",
                                          IngredientCategory.herb => "(tbsp)",
                                          IngredientCategory.spice =>
                                            "(g, to taste)",
                                          IngredientCategory.fruit => "(g/kg)",
                                          IngredientCategory.grain => "(g/kg)",
                                          IngredientCategory.other =>
                                            "(g/kg, mL/L)",
                                        },
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// Category Dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(),
                  ),
                  items: ['Breakfast', 'Lunch', 'Dinner', 'Dessert', 'Snack']
                      .map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  value:
                      validateNullRecipe ? currentGroceryItem!.category : null,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// Prep-time Input
                TextFormField(
                  initialValue: validateNullRecipe
                      ? currentGroceryItem!.prepTime.toString()
                      : "",
                  decoration: const InputDecoration(
                    labelText: 'Prep Time (minutes)',
                    prefixIcon: Icon(Icons.timer),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      _validatePositiveNumber(value, 'Prep time'),
                  onSaved: (newValue) =>
                      _enteredPrepTime = int.parse(newValue!),
                ),

                const SizedBox(height: 16),

                /// Cook Time Input
                TextFormField(
                  initialValue: validateNullRecipe
                      ? currentGroceryItem!.cookTime.toString()
                      : "",
                  decoration: const InputDecoration(
                    labelText: 'Cook Time (minutes)',
                    prefixIcon: Icon(Icons.fireplace),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      _validatePositiveNumber(value, 'Cook time'),
                  onSaved: (newValue) =>
                      _enteredCookTime = int.parse(newValue!),
                ),

                const SizedBox(height: 16),

                /// Servings Input
                TextFormField(
                  initialValue: validateNullRecipe
                      ? currentGroceryItem!.servings.toString()
                      : "",
                  decoration: const InputDecoration(
                    labelText: 'Number of Servings',
                    prefixIcon: Icon(Icons.people),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      _validatePositiveNumber(value, 'Servings'),
                  onSaved: (newValue) =>
                      _enteredServings = int.parse(newValue!),
                ),

                const SizedBox(height: 16),

                /// Steps
                Text(
                  'Steps',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Column(
                  children: List.generate(_stepControllers.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _stepControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Steps ${index + 1}',
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) => _validateStep(value, index),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle,
                                color: Colors.green),
                            onPressed: () {
                              setState(() {
                                _stepControllers.add(TextEditingController());
                              });
                            },
                          ),
                          if (_stepControllers.length > 1)
                            IconButton(
                              icon: const Icon(Icons.remove_circle,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _stepControllers.removeAt(index);
                                });
                              },
                            ),
                        ],
                      ),
                    );
                  }),
                ),

                /// Image Picker
                ElevatedButton.icon(
                  onPressed: () async {
                    await pickImage();
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Pick an Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[200],
                  ),
                ),

                if (_imagePath != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.file(File(_imagePath!), height: 200),
                  ),

                const SizedBox(height: 16),

                /// Favorite Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mark as Favorite',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: _isFavorite,
                      onChanged: (bool newValue) {
                        setState(() {
                          _isFavorite = newValue;
                        });
                      },
                    )
                  ],
                ),

                const SizedBox(height: 16),

                /// Submit Button
                ElevatedButton(
                  onPressed: _saveRecipe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Save Recipe',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
