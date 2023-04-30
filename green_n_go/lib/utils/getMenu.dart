import 'package:flutter/material.dart';
import 'package:green_n_go/classes/foodItem.dart';
import 'package:green_n_go/screens/marciano.dart';
import 'package:green_n_go/screens/review.dart';
import 'package:intl/intl.dart';

class ReturnMenu extends StatefulWidget {
  final List<FoodItem> selectedMealType;
  final String dhall;
  final String mealTime;

  ReturnMenu(
      {Key? key,
      required this.selectedMealType,
      required this.dhall,
      required this.mealTime})
      : super(key: key);

  @override
  _ReturnMenuState createState() => _ReturnMenuState();
}

class _ReturnMenuState extends State<ReturnMenu> {
  bool _isVeganSelected = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // Filter the food list based on whether it is vegan or not
    final filteredList = widget.selectedMealType.where((food) {
      return !_isVeganSelected || (food.is_vegan ?? false);
    }).toList();
    double screenHeight = MediaQuery.of(context).size.height;
    double height = screenHeight * 0.9;

    return Stack(children: [
      Column(
        children: [
          // SizedBox(
          //     height: 20,
          //     child: Text(widget.mealTime,
          //         style: const TextStyle(
          //             fontSize: 20, fontWeight: FontWeight.bold))),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 5,
              ),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final food = filteredList[index];
                food.sugars ??= 0;
                return GestureDetector(
                    child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      Flexible(
                        flex: 1,
                        child: ListTile(
                          title: SizedBox(
                            height: 40,
                            child: Text(
                              food.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onTap: () {},
                          subtitle: SizedBox(
                            height: 50,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  food.description ?? '',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 87, 91, 87),
                                      fontSize: 13),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ButtonTheme(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              constraints:
                                  BoxConstraints.expand(height: 0.8 * height),
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return ReviewScreens(
                                  foodItem: food,
                                  diningHall: widget.dhall,
                                );
                              },
                            );
                          },
                          label: Text(
                            food.rating.toString(),
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                          icon: const Icon(
                            Icons.pets,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(40, 40)),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                final rating = food.rating ?? 0;
                                if (rating >= 4) {
                                  return const Color.fromARGB(
                                      255, 119, 178, 122);
                                } else if (rating >= 2) {
                                  return const Color.fromARGB(
                                      255, 255, 204, 102);
                                } else {
                                  return const Color.fromARGB(
                                      255, 255, 102, 102);
                                }
                              },
                            ),
                            shape: MaterialStateProperty.all<StadiumBorder>(
                              const StadiumBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              },
            ),
          ),
        ],
      ),
      Positioned(
        bottom: 30,
        right: 10,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: PopupMenuButton<bool>(
            icon: Image.asset('assets/images/filter.png'),
            iconSize: 60,
            onSelected: (value) {
              setState(() {
                _isVeganSelected = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<bool>>[
              const PopupMenuItem<bool>(
                value: false,
                child: Text('All'),
              ),
              const PopupMenuItem<bool>(
                value: true,
                child: Text('Vegan'),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

Future<void> getMenu() async {
  print(formattedDate);
  final snapshot =
      await ref.child("menu/$formattedDate/warren/Breakfast").get();
  if (snapshot.exists && snapshot.value is Map<dynamic, dynamic>) {
    (snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
      final food = FoodItem(
          name: value['name'],
          description: value['description'],
          carbs: value['carbohydrates'],
          protiens: value['protein'],
          satFat: value['saturated_fat'],
          // sugars: value['sugars'],
          cals: value['calories'],
          rating: value['rating'],
          is_vegan: value['is_vegan'],
          is_vegetarian: value['is_vegetarian']);
      bmenu.add(food);
    });
  } else {
    print('No data available.');
  }
  final snapshot1 = await ref.child("menu/$formattedDate/warren/Lunch").get();
  if (snapshot1.exists && snapshot1.value is Map<dynamic, dynamic>) {
    (snapshot1.value as Map<dynamic, dynamic>).forEach((key, value) {
      final food = FoodItem(
          name: value['name'],
          description: value['description'],
          carbs: value['carbohydrates'],
          protiens: value['protein'],
          satFat: value['saturated_fat'],
          // sugars: value['sugars'],
          cals: value['calories'],
          rating: value['rating'],
          is_vegan: value['is_vegan'],
          is_vegetarian: value['is_vegetarian']);
      lmenu.add(food);
    });
  } else {
    print('No data available.');
  }
  final snapshot2 = await ref.child("menu/$formattedDate/warren/Dinner").get();
  if (snapshot2.exists && snapshot2.value is Map<dynamic, dynamic>) {
    (snapshot2.value as Map<dynamic, dynamic>).forEach((key, value) {
      final food = FoodItem(
          name: value['name'],
          description: value['description'],
          carbs: value['carbohydrates'],
          protiens: value['protein'],
          satFat: value['saturated_fat'],
          // sugars: value['sugars'],
          cals: value['calories'],
          rating: value['rating'],
          is_vegan: value['is_vegan'],
          is_vegetarian: value['is_vegetarian']);
      dmenu.add(food);
    });
  } else {
    print('No data available.');
  }
}
