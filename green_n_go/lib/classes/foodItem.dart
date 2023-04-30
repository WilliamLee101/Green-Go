class FoodItem {
  final String name;
  final String? description;
  final int? carbs;
  final int? protiens;
  final int? satFat;
  int? sugars;
  final int? cals;
  final double? rating;
  final bool? is_vegan;
  final bool? is_vegetarian;

  FoodItem(
      {required this.name,
      this.description,
      this.carbs,
      this.protiens,
      this.satFat,
      this.sugars,
      this.cals,
      this.rating,
      this.is_vegan,
      this.is_vegetarian,
      required proteins});
}
