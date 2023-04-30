import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:green_n_go/utils/getMenu.dart';
import 'package:green_n_go/utils/navBar.dart';
import 'package:intl/intl.dart';
import '../classes/foodItem.dart';
import 'package:green_n_go/screens/personalProfile.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);
final List<FoodItem> bmenu = [];
final List<FoodItem> lmenu = [];
final List<FoodItem> dmenu = [];

final ref = FirebaseDatabase.instance.ref();

//Create widget for displaying west dininng hall
class West extends StatefulWidget {
  const West({super.key});

  @override
  State<West> createState() => _WestState();
}

class _WestState extends State<West> with TickerProviderStateMixin {
  List<FoodItem> _selectedMealType = bmenu;
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

  void _onPageChanged(int index) {
    setState(() {
      controller?.index = index;
    });
  }

  //Main function to populate array of food items from firebase
  Future<void> getMenu() async {
    final snapshot =
        await ref.child("menu/$formattedDate/west/Breakfast").get();
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
    final snapshot1 = await ref.child("menu/$formattedDate/west/Lunch").get();
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
    final snapshot2 = await ref.child("menu/$formattedDate/west/Dinner").get();
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
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu at West', style: TextStyle(fontSize: 27)),
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
                      dhall: "west",
                      mealTime: "Breakfast"),
                  ReturnMenu(
                      selectedMealType: lmenu,
                      dhall: "west",
                      mealTime: "Lunch"),
                  ReturnMenu(
                      selectedMealType: dmenu,
                      dhall: "west",
                      mealTime: "Dinner"),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const NavBar());
  }
}
