import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:green_n_go/screens/review.dart';
import 'package:intl/intl.dart';
import 'package:green_n_go/profileView.dart';

import '../widgets/foodItem.dart';
import '../widgets/getMenu.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

final List<FoodItem> bmenu = [];
final List<FoodItem> lmenu = [];
final List<FoodItem> dmenu = [];

final ref = FirebaseDatabase.instance.ref();

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
  final snapshot1 = await ref.child("menu/$formattedDate/marciano/Lunch").get();
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
  }

  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[Marciano(), ProfileView()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  final Color darkGreen = Color(0xFF3B7D3C);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    getMenu();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu at Marciano', style: TextStyle(fontSize: 27)),
        backgroundColor: Color(0xff3B7D3C),
        toolbarHeight: .1 * height,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          ReturnMenu(selectedMealType: bmenu),
          ReturnMenu(selectedMealType: lmenu),
          ReturnMenu(selectedMealType: dmenu),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dining),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
