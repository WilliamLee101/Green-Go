import 'package:flutter/material.dart';
import 'package:green_n_go/widgets/foodItem.dart';
import 'package:green_n_go/screens/marciano.dart';
import 'package:green_n_go/screens/review.dart';

class ReturnMenu extends StatelessWidget {
  final List<FoodItem> selectedMealType;

  const ReturnMenu({super.key, required this.selectedMealType});
  @override
  Widget build(BuildContext context) {
    String when = 'Breakfast';
    if (selectedMealType == lmenu) {
      when = 'Lunch';
    } else if (selectedMealType == dmenu) {
      when = 'Dinner';
    }
    return Column(
      children: [
        SizedBox(height: 20, child: Text(when)),
        Expanded(
          child: ListView.builder(
            itemCount: selectedMealType.length,
            itemBuilder: (context, index) {
              final food = selectedMealType[index];
              food.sugars ??= 0;
              return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                      title: Text(food.name),
                      trailing: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ReviewSurveyScreen(
                                foodItem: food,
                              );
                            },
                          );
                        },
                        child: const Text('Review'),
                      ),
                      onTap: () {},
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(food.description ?? ''),
                            Text('${food.cals} cals' ?? ''),
                            Text('${food.protiens}g protein' ?? ''),
                            Text('${food.satFat}g fat' ?? ''),
                            Text('${food.sugars}g sugar'),
                            Text('${food.carbs}g carbs' ?? ''),
                          ])));
            },
          ),
        ),
      ],
    );
  }
}
