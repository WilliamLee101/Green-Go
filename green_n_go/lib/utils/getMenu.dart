import 'package:flutter/material.dart';
import 'package:green_n_go/classes/foodItem.dart';
import 'package:green_n_go/screens/marciano.dart';
import 'package:green_n_go/screens/review.dart';

class ReturnMenu extends StatefulWidget {
  final List<FoodItem> selectedMealType;

  ReturnMenu({Key? key, required this.selectedMealType}) : super(key: key);

  @override
  _ReturnMenuState createState() => _ReturnMenuState();
}

class _ReturnMenuState extends State<ReturnMenu> {
  bool _isVeganSelected = false;

  @override
  Widget build(BuildContext context) {
    String when = 'Breakfast';
    if (widget.selectedMealType == lmenu) {
      when = 'Lunch';
    } else if (widget.selectedMealType == dmenu) {
      when = 'Dinner';
    }

    // Filter the food list based on whether it is vegan or not
    final filteredList = widget.selectedMealType.where((food) {
      return !_isVeganSelected || (food.is_vegan ?? false);
    }).toList();
    double height = MediaQuery.of(context).size.height;
    return Stack(children: [
      Column(
        children: [
          SizedBox(height: 20, child: Text(when)),
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
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 400,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  "Nutritional Detail",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(
                                  color: Colors.green[800],
                                  thickness: 2,
                                ),

                                // make space
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  food.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  food.description ?? '',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  "Nutritional Detail",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${food.carbs?.toString() ?? ''} carbs',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${food.protiens?.toString() ?? ''} protiens',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${food.satFat?.toString() ?? ''} satFat',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${food.sugars?.toString() ?? ''} sugars',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${food.cals?.toString() ?? ''} cals',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                      );
                    },
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
                                          color:
                                              Color.fromARGB(255, 87, 91, 87),
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
                                  constraints: BoxConstraints.expand(
                                      height: 0.9 * height),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ReviewScreens(
                                      foodItem: food,
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
                                minimumSize: MaterialStateProperty.all(
                                    const Size(40, 40)),
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
                _isVeganSelected = value ?? false;
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
