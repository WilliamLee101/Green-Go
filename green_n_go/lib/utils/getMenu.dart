import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:green_n_go/classes/foodItem.dart';
import 'package:green_n_go/screens/marciano.dart';
import 'package:green_n_go/screens/review.dart';
import 'package:green_n_go/utils/navBar.dart';
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
  late List<FoodItem> filteredList;
  bool _isVeganSelected = false;

  @override
  Widget build(BuildContext context) {
    // Filter the food list based on whether it is vegan or not

    filteredList = widget.selectedMealType.where((food) {
      if (_isVeganSelected == true) {
        return (food.is_vegan ?? false);
      } else {
        return (true);
      }
    }).toList();

    // print("inside widget");
    // print(widget.mealTime);
    // print(widget.dhall);
    // print(widget.selectedMealType);

    double screenHeight = MediaQuery.of(context).size.height;
    double height = screenHeight;


    //Case where there are no food items available
    if (widget.selectedMealType.isEmpty) {
      print("emtpy array ");
      return Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: height * 0.2),
                const Text(
                  "Oops!",
                  style: TextStyle(
                    color: Color(0xff3B7D3C),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'There are no ${widget.mealTime.toLowerCase()}\n items available at this time.',
                  style: const TextStyle(
                    color: Color(0xff3B7D3C),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: height > 700 ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Stack(children: [
        Column(
          children: [
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
                                isDismissible: true,
                                enableDrag: true,
                                constraints:
                                    BoxConstraints.expand(height: 0.6 * height),
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0),
                                  ),
                                ),
                                backgroundColor: Colors.transparent,
                                clipBehavior: Clip.antiAlias,
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
}
