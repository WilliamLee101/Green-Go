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

//Create widget for displaying Marciano dininng hall
class Marciano extends StatefulWidget {
  const Marciano({super.key});
  @override
  State<Marciano> createState() => _MarcianoState();
}

class _MarcianoState extends State<Marciano> with TickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  TabController? controller;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    getMenu();
    controller = TabController(
      length: 3,
      vsync: this,
    );
  }

  List<String> mealTimes = ["Breakfast", "Lunch", "Dinner"];
  int mealTimeIndex = 0;

  //Main function to populate Marciano dining hall menu
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
            proteins: value['protein'],
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
            proteins: value['protein'],
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
            proteins: value['protein'],
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
    setState(() {}); // trigger a re-build of the UI
  }

  void _onPageChanged(int index) {
    setState(() {
      controller?.index = index;
      mealTimeIndex = index;
    });
  }

  final Color darkGreen = Color(0xFF3B7D3C);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('${mealTimes[mealTimeIndex]} at Marciano',
              style: TextStyle(fontSize: 27)),
          backgroundColor: Color(0xff3B7D3C),
          toolbarHeight: .1 * height,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        ),
        body: Column(
          children: [
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabPageSelector(
                  controller: controller,
                  color: Color(0xffD9D9D9),
                  borderStyle: BorderStyle.none,
                  selectedColor: Color(0xff3B7D3C),
                ),
                SizedBox(width: width * 0.1)
              ],
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  ReturnMenu(
                      selectedMealType: bmenu,
                      dhall: "marciano",
                      mealTime: "Breakfast"),
                  ReturnMenu(
                      selectedMealType: lmenu,
                      dhall: "marciano",
                      mealTime: "Lunch"),
                  ReturnMenu(
                      selectedMealType: dmenu,
                      dhall: "marciano",
                      mealTime: "Dinner"),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const NavBar());
  }
}
