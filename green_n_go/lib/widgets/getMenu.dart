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
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 5),
            itemCount: selectedMealType.length,
            itemBuilder: (context, index) {
              final food = selectedMealType[index];
              food.sugars ??= 0;
              return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                      title: Text(food.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          )),
                      trailing: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            // minimumSize: Size.zero,
                            padding: EdgeInsets.all(5),
                            backgroundColor: Color.fromARGB(255, 169, 240, 172),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () => {
                                showBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ReviewSurveyScreen(foodItem: food);
                                  },
                                )
                              },
                          label: Text(
                            food.rating.toString(),
                            style: TextStyle(
                                // color: Color.fromARGB(
                                //     255, 241, 220, 104)
                                ),
                          ),
                          icon: Image.asset(
                            'assets/images/reviewButton.png',
                            color: Color.fromARGB(255, 67, 118, 10),
                            height: 20,
                            width: 20,
                          )),
                      onTap: () {},
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(food.description ?? '',
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .apply(fontSizeFactor: 0.8)),
                            // Text('${food.cals} cals' ?? ''),
                            // Text('${food.protiens}g protein' ?? ''),
                            // Text('${food.satFat}g fat' ?? ''),
                            // Text('${food.sugars}g sugar'),
                            // Text('${food.carbs}g carbs' ?? ''),
                          ])));
            },
          ),
        ),
      ],
    );
  }
}
