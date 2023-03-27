
class FoodItem {
  final String name;
  final String? description;
  final int? carbs;
  final int? protiens;
  final int? satFat;
  int? sugars;
  final int? cals;

  FoodItem(
      {required this.name,
      this.description,
      this.carbs,
      this.protiens,
      this.satFat,
      this.sugars,
      this.cals});
}