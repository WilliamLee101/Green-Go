import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:green_n_go/screens/review.dart';
import 'package:intl/intl.dart';

import '../widgets/foodItem.dart';
import '../widgets/getMenu.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

final List<FoodItem> bmenu = [];
final List<FoodItem> lmenu = [];
final List<FoodItem> dmenu = [];

final ref = FirebaseDatabase.instance.ref();

class Marciano extends StatefulWidget {
  const Marciano({super.key});
  @override
  State<Marciano> createState() => _MarcianoState();
}

class _MarcianoState extends State<Marciano> {

  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    getMenu();
  }
  Future<void> getMenu() async {
    print(formattedDate);
    final snapshot =
        await ref.child("menu/$formattedDate/marciano/Breakfast").get();
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
    final snapshot1 =
        await ref.child("menu/$formattedDate/marciano/Lunch").get();
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
        await ref.child("menu/$formattedDate/marciano/Dinner").get();
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

  final Color darkGreen = Color(0xFF3B7D3C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marciano Menu'),
        backgroundColor: darkGreen,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          ReturnMenu(selectedMealType: bmenu),
          ReturnMenu(selectedMealType: lmenu),
          ReturnMenu(selectedMealType: dmenu),
        ],
      ),
    );
  }
}
