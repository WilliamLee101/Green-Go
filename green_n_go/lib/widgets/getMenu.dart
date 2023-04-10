import 'package:flutter/material.dart';
import 'package:green_n_go/widgets/foodItem.dart';
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

    return Stack(children: [
      Column(children: [
        SizedBox(height: 20, child: Text(when)),
        Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 5,
                ),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final food = filteredList[index];
                  food.sugars ??= 0;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text(
                        food.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          // minimumSize: Size.zero,
                          padding: EdgeInsets.all(5),
                          backgroundColor: Color.fromARGB(255, 169, 240, 172),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () => {
                          showBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ReviewSurveyScreen(foodItem: food);
                            },
                          ),
                        },
                        label: Text(
                          food.rating.toString(),
                          style: TextStyle(
                              // color: Color.fromARGB(
                              //     255, 241, 220, 104)
                              ),
                        ),
                        icon: Image.asset(
                          'assets/images/reviewButton.png',
                          color: Color.fromARGB(255, 67, 118, 10),
                          height: 20,
                          width: 20,
                        ),
                      ),
                      onTap: () {},
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.description ?? '',
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 0.8),
                          ),
                        ],
                      ),
                    ),
                  );
                  ;
                })),
      ]),
      Positioned(
        bottom: 35,
        right: 20,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 46, 145, 13).withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
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
              PopupMenuItem<bool>(
                value: false,
                child: Text('All'),
              ),
              PopupMenuItem<bool>(
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
