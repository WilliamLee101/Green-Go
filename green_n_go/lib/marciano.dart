
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';

class FoodItem {
  final String name;
  final int? carbs;
  final int? protiens;
  final int? satFat;
  final int? sugars;
  final int? cals;

  const FoodItem(
      {required this.name,
      this.carbs,
      this.protiens,
      this.satFat,
      this.sugars,
      this.cals});
}

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
    print(formattedDate);
    final snapshot =
        await ref.child("menu/" + formattedDate + "/marciano/breakfast").get();
    if (snapshot.exists && snapshot.value is Map<dynamic, dynamic>) {
      (snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
        final food = FoodItem(
          name: value['name'],
          carbs: value['carbohydrates'],
          protiens: value['protein'],
          satFat: value['saturated_fat'],
          // sugars: value['sugars'],
          cals: value['calories'],
        );
        bmenu.add(food);
      });
    } else {
      print('No data available.');
    }
    final snapshot1 =
        await ref.child("menu/" + formattedDate + "/marciano/Lunch").get();
    if (snapshot1.exists && snapshot1.value is Map<dynamic, dynamic>) {
      (snapshot1.value as Map<dynamic, dynamic>).forEach((key, value) {
        final food = FoodItem(
          name: value['name'],
          carbs: value['carbohydrates'],
          protiens: value['protein'],
          satFat: value['saturated_fat'],
          // sugars: value['sugars'],
          cals: value['calories'],
        );
        lmenu.add(food);
      });
    } else {
      print('No data available.');
    }
    final snapshot2 =
        await ref.child("menu/" + formattedDate + "/marciano/Dinner").get();
    if (snapshot2.exists && snapshot2.value is Map<dynamic, dynamic>) {
      (snapshot2.value as Map<dynamic, dynamic>).forEach((key, value) {
        final food = FoodItem(
          name: value['name'],
          carbs: value['carbohydrates'],
          protiens: value['protein'],
          satFat: value['saturated_fat'],
          // sugars: value['sugars'],
          cals: value['calories'],
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
              title: const Text('Marciano Menu'),
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
                        print("lunch selected");
                      });
                    },
                    child: Text('Lunch'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMealType = dmenu;
                        print("dining selected");
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
                            trailing: Text(food.cals.toString() + ' cals' ?? ''),
                            onTap: () {},
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(food.protiens.toString() +'g' ?? ''),
                                  Text(food.satFat.toString() +'g' ?? ''),
                                  Text(food.sugars.toString() +'g' ?? ''),
                                  Text(food.carbs.toString() +'g' ?? ''),
                                ])));
                  },
                ),
              )
            ])));
  }
}
