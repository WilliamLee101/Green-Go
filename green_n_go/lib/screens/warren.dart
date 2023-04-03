import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:green_n_go/screens/review.dart';
import 'package:intl/intl.dart';

import '../widgets/foodItem.dart';

DateTime now = DateTime.now();

String formattedDate = DateFormat('yyyy-MM-dd').format(now);

final List<FoodItem> bmenu = [];
final List<FoodItem> lmenu = [];
final List<FoodItem> dmenu = [];

final ref = FirebaseDatabase.instance.ref();

class Warren extends StatefulWidget {
  const Warren({super.key});
  @override
  State<Warren> createState() => _WarrenState();
}

class _WarrenState extends State<Warren> {
  List<FoodItem> _selectedMealType = bmenu;
  @override
  void initState() {
    super.initState();
    getMenu().then((value) {
      setState(() {
        // set the selected meal type to breakfast by default
        _selectedMealType = bmenu;
      });
    });
  }

  Future<void> getMenu() async {
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

    final snapshot2 =
        await ref.child("menu/$formattedDate/warren/Dinner").get();

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: const Text('Warren Menu',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                backgroundColor: Colors.white),
            body: Column(children: [
              // row for breakfast lunch and dinner options on the top
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMealType = bmenu;
                      });
                    },
                    child: const Text('Breakfast'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMealType = lmenu;
                      });
                    },
                    child: Text('Lunch'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMealType = dmenu;
                      });
                    },
                    child: Text('Dinner'),
                  ),
                ],
              ),

              // expanded row for all of the menu items and their nutrional data

              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 5),
                  itemCount: _selectedMealType.length,
                  itemBuilder: (context, index) {
                    final food = _selectedMealType[index];
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
                            onTap: () {},
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(food.description ?? '',
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .apply(fontSizeFactor: 0.8)),
                                  // Text('${food.cals} cals' ?? ''),
                                  // Text('${food.protiens}g protein' ?? ''),
                                  // Text('${food.satFat}g fat' ?? ''),
                                  // Text('${food.sugars}g sugar' ?? ''),
                                  // Text('${food.carbs}g carbs' ?? ''),
                                ]),
                            trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // Expanded(
                                  //     child: Container(
                                  //         width: 20,
                                  //         height: 50,
                                  //         decoration: BoxDecoration(
                                  //             shape: BoxShape.circle,
                                  //             border: Border.all(
                                  //                 color: Colors.green,
                                  //                 width: 15,
                                  //                 style: BorderStyle.solid)),
                                  //         child: const Icon(Icons.pets_outlined,
                                  //             color: Colors.lightGreen))),
                                  // const Text(
                                  //   ' # of reviews',
                                  //   style: TextStyle(
                                  //       fontSize: 9,
                                  //       fontWeight: FontWeight.normal),
                                  //   textAlign: TextAlign.left,
                                  // ),
                                  Expanded(
                                      child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            // minimumSize: Size.zero,
                                            padding: EdgeInsets.all(5),
                                            backgroundColor: Color.fromARGB(
                                                255, 169, 240, 172),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                          ),
                                          onPressed: () => {
                                                showBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ReviewSurveyScreen(
                                                        foodItem: food);
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
                                            color: Color.fromARGB(
                                                255, 67, 118, 10),
                                            height: 20,
                                            width: 20,
                                          ))),
                                ])));
                  },
                ),
              )
            ])));
  }
}
