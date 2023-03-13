import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FoodItem {
  final String name;
  final String? carbs;
  final String? protiens;
  final String? satFat;
  final String? sugars;
  final String? cals;

  const FoodItem(
      {required this.name,
      this.carbs,
      this.protiens,
      this.satFat,
      this.sugars,
      this.cals});
}

DateTime date = DateTime.now();
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
        await ref.child("updated_menu/2023-03-13/warren/breakfast").get();
    if (snapshot.exists && snapshot.value is Map<dynamic, dynamic>) {
      (snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
        final food = FoodItem(
          name: value['item'],
          carbs: value['carbs'],
          protiens: value['proteins'],
          satFat: value['saturated fat'],
          sugars: value['sugars'],
          cals: value['cals'],
        );
        bmenu.add(food);
      });
    } else {
      print('No data available.');
    }
    final snapshot1 =
        await ref.child("updated_menu/2023-03-13/warren/lunch").get();
    if (snapshot1.exists && snapshot1.value is Map<dynamic, dynamic>) {
      (snapshot1.value as Map<dynamic, dynamic>).forEach((key, value) {
        final food = FoodItem(
          name: value['item'],
          carbs: value['carbs'],
          protiens: value['proteins'],
          satFat: value['saturated fat'],
          sugars: value['sugars'],
          cals: value['cals'],
        );
        lmenu.add(food);
      });
    } else {
      print('No data available.');
    }
    final snapshot2 =
        await ref.child("updated_menu/2023-03-13/warren/dinner").get();
    if (snapshot2.exists && snapshot2.value is Map<dynamic, dynamic>) {
      (snapshot2.value as Map<dynamic, dynamic>).forEach((key, value) {
        final food = FoodItem(
          name: value['item'],
          carbs: value['carbs'],
          protiens: value['proteins'],
          satFat: value['saturated fat'],
          sugars: value['sugars'],
          cals: value['cals'],
        );
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
              title: const Text('Warren Menu'),
            ),
            body: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMealType = bmenu;
                      });
                    },
                    child: Text('Breakfast'),
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
              Expanded(
                child: ListView.builder(
                  itemCount: _selectedMealType.length,
                  itemBuilder: (context, index) {
                    final food = _selectedMealType[index];
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                            title: Text(food.name),
                            trailing: Text(food.cals ?? ''),
                            onTap: () {},
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(food.protiens ?? ''),
                                  Text(food.satFat ?? ''),
                                  Text(food.sugars ?? ''),
                                  Text(food.carbs ?? ''),
                                ])));
                  },
                ),
              )
            ])));
  }
}
