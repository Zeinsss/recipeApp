enum IngredientCategory {
  dairy("Dairy"),
  vegetable("Vegetable"),
  meat("Meat"),
  fat("Fat"),
  herb("Herb"),
  spice("Spice"),
  fruit("Fruit"),
  grain("Grain"),
  other("Other");

  final String name;
  const IngredientCategory(this.name);
}

class Ingredient {
  final String name;
  final IngredientCategory category;
  final String unit;

  Ingredient({required this.category, required this.name, required this.unit});

  @override
  String toString() {
    return '$name ($category), Unit: $unit';
  }
}
