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
                          borderRadius: BorderRadius.circular(20.0)),
                      child: ListTile(
                        title: Text(food.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            )),
                        onTap: () {},
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                food.description ?? '',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 87, 91, 87)),
                                // style: DefaultTextStyle.of(context)
                                //     .style
                                //     .apply(fontSizeFactor: 0.8),
                                textAlign: TextAlign.center,
                              ),
                              // Text('${food.cals} cals' ?? ''),
                              // Text('${food.protiens}g protein' ?? ''),
                              // Text('${food.satFat}g fat' ?? ''),
                              // Text('${food.sugars}g sugar' ?? ''),
                              // Text('${food.carbs}g carbs' ?? ''),
                              ButtonTheme(
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton.icon(
                                          // style: ElevatedButton.styleFrom(
                                          //   // minimumSize: Size.zero,
                                          // backgroundColor: const Color.fromARGB(
                                          //     255, 119, 178, 122),
                                          //   shape: RoundedRectangleBorder(
                                          //     borderRadius:
                                          //         BorderRadius.circular(10.0),
                                          //   ),
                                          // ),
                                          onPressed: () => {
                                                showBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ReviewSurveyScreen(
                                                        foodItem: food);
                                                  },
                                                )
                                              },
                                          label: Text(
                                            food.rating.toString(),
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Color.fromARGB(
                                                    255, 48, 121, 51)),
                                          ),
                                          icon: const Icon(Icons.pets,
                                              color: Color.fromARGB(
                                                  255, 48, 121, 51)),
                                          style: ButtonStyle(
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size(50, 20)),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color.fromARGB(
                                                          255, 162, 204, 167)!),
                                              shape: MaterialStateProperty.all<
                                                  StadiumBorder>(
                                                StadiumBorder(),
                                              ))))),
                            ]),

                        // mainAxisAlignment:
                        //     MainAxisAlignment.spaceBetween,

                        // Expanded(
                        //     child: Container(
                        //         width: 20,
                        //         height: 50,
                        //         decoration: BoxDecoration(
                        //             shape: BoxShape.circle,
                        //             border: Border.all(
                        //                 color: Colors.green,
                        //                 width: 15,
                        //                 style: BorderStyle.solid)),
                        //         child: const Icon(Icons.pets_outlined,
                        //             color: Colors.lightGreen))),
                        // const Text(
                        //   ' # of reviews',
                        //   style: TextStyle(
                        //       fontSize: 9,
                        //       fontWeight: FontWeight.normal),
                        //   textAlign: TextAlign.left,
                        // ),
                      ));
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
