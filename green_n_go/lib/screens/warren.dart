import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:green_n_go/utils/navBar.dart';
import 'package:intl/intl.dart';
import 'package:green_n_go/screens/personalProfile.dart';

import '../classes/foodItem.dart';
import '../utils/getMenu.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

final List<FoodItem> bmenu = [];
final List<FoodItem> lmenu = [];
final List<FoodItem> dmenu = [];

final ref = FirebaseDatabase.instance.ref();

//Create widget for displaying warren dininng hall
class Warren extends StatefulWidget {
  const Warren({super.key});
  @override
  State<Warren> createState() => _WarrenState();
}

class _WarrenState extends State<Warren> with TickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  TabController? controller;

  @override
  void initState() {
    super.initState();
    getMenu();
    controller = TabController(
      length: 3,
      vsync: this,
    );
  }

  //Main function to populate warren dining hall menu
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

  void _onPageChanged(int index) {
    setState(() {
      controller?.index = index;
    });
  }

  final Color darkGreen = Color(0xFF3B7D3C);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu at Warren', style: TextStyle(fontSize: 27)),
          backgroundColor: Color(0xff3B7D3C),
          toolbarHeight: .1 * height,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabPageSelector(
                  controller: controller,
                  color: Color(0xffD9D9D9),
                  borderStyle: BorderStyle.none,
                  selectedColor: Color(0xff3B7D3C),
                ),
                const SizedBox(width: 20)
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  ReturnMenu(
                      selectedMealType: bmenu,
                      dhall: "warren",
                      mealTime: "Breakfast"),
                  ReturnMenu(
                      selectedMealType: lmenu,
                      dhall: "warren",
                      mealTime: "Lunch"),
                  ReturnMenu(
                      selectedMealType: dmenu,
                      dhall: "warren",
                      mealTime: "Dinner"),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const NavBar());
  }
}
