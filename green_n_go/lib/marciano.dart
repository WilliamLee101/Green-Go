import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

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
Future<void> getMenu() async {
  final snapshot =
      await ref.child("updated_menu/2023-03-13/marciano/breakfast").get();
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
      await ref.child("updated_menu/2023-03-13/marciano/lunch").get();
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
      await ref.child("updated_menu/2023-03-13/marciano/dinner").get();
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
      print(food.name);
      print(food.cals);
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
  @override
  Widget build(BuildContext context) {
    getMenu();
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
        title: const Text('Marciano Menu'),
        ),
        body: ListView.builder(
          itemCount: bmenu.length,
          itemBuilder: (context,index) {
            final food = bmenu[index];
            return ListTile(
              title: Text(food.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.cals ?? ''),
                  Text(food.protiens ?? ''),
                  Text(food.satFat ?? ''),
                  Text(food.sugars ?? ''),
                  Text(food.carbs ?? ''),
                ]
              )
              
            );
          },
      ),
    ));
  }
}
