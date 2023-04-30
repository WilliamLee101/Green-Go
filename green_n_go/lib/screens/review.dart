import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:green_n_go/main.dart';
import 'package:image_picker/image_picker.dart';
import '../classes/foodItem.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

//This is the review screen widget that is displayed when users want to create a review
class ReviewSurveyScreen extends StatefulWidget {
  final FoodItem foodItem;
  final String diningHall;
  final String mealTime;

  ReviewSurveyScreen(
      {required this.foodItem,
      required this.diningHall,
      required this.mealTime});

  @override
  _ReviewSurveyScreenState createState() => _ReviewSurveyScreenState();
}

class _ReviewSurveyScreenState extends State<ReviewSurveyScreen> {
  double _rating = 0.0;
  double _amount_finished = 0.0;
  String _comment = '';
  File? imageFile;
  TextEditingController _commentController = TextEditingController();
  String _current_date = "";

  Future<void> _takeAndUploadPicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
        return;
      }
    });

    final path =
        "${widget.diningHall.toString()}/${widget.foodItem.name.toString()}";
    final ref = FirebaseStorage.instance.ref().child(path);

    await ref.putFile(imageFile!);
  }

  //Function to upload user review data to firebase
  void _submitReview() {
    int database_num_rating = 0;
    double database_rating = 0.0;

    // Create a reference to the top-level food collection
    CollectionReference foodCollectionRef =
        FirebaseFirestore.instance.collection('food');
    CollectionReference dateCollectionRef =
        foodCollectionRef.doc(formattedDate).collection(widget.foodItem.name);

    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    _current_date = DateFormat('yyyy-MM-dd')
        .format(date); // Output format: "yyyy-mm-dd hh:mm:ss"
    final user = FirebaseAuth.instance.currentUser;
    String userID = user!.uid;
    print("userID: " + userID);

    CollectionReference userInfoRef =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userInfoUpdateRef = userInfoRef.doc(userID);

    userInfoUpdateRef
        .update({"num_comments_made": FieldValue.increment(1)}).then((value) {
      print("update num_comments_made successfully!");
    }).catchError((error) {
      // Handle any errors that occur while updating the document
      print("error during updating num_comments_made");
    });

    if (_amount_finished >= 80) {
      userInfoUpdateRef.update(
          {"num_plates_finished": FieldValue.increment(1)}).then((value) {
        // Update successful
        print("update num_plates_finished successfully!");
      }).catchError((error) {
        // Handle any errors that occur while updating the document
        print("error during updating num_plates_finished");
      });
    }

    // update realtime database
    final DatabaseReference dbRef = FirebaseDatabase.instance
        .reference()
        .child('menu')
        .child(formattedDate)
        .child(widget.diningHall)
        .child(widget.mealTime)
        .child(widget.foodItem.name);

    dbRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      dynamic foodData = snapshot.value;
      database_rating = foodData["rating"];
      database_num_rating = foodData["num_rating"];

      String inString = ((database_rating * database_num_rating + _rating) /
              (database_num_rating + 1))
          .toStringAsFixed(1);

      double newRating = double.parse(inString);

      int newNumRatings = database_num_rating + 1;

      dbRef.update({"rating": newRating, "num_rating": newNumRatings});

      print(widget.foodItem.name);
      print("database_rating");
      print(database_rating);
      print("newRating");
      print(newRating);
    });

    // Submit review to backend
    dateCollectionRef.add({
      'rating': _rating,
      'amount_finished': _amount_finished,
      'comment': _comment,
      'posted_date': _current_date,
    }).then((value) {
      // Reset slider values and clear text field
      setState(() {
        _rating = 0;
        _amount_finished = 0;
        _comment = '';
        _commentController.clear();
        _current_date = "";
      });
      // Show pop-up message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Review Submitted'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/submitted.png',
                  height: 150,
                ),
                SizedBox(height: 16.0),
                Text('Thank you for submitting your review.'),
              ],
            ),
            actions: [
              Center(
                child: TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true, // remove the extra argument here

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Rate your experience",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      SizedBox(height: height * 0.05),
                      SizedBox(width: width * 0.05),
                      const Text("How did you like it?",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 17.1429,
                              fontFamily: 'Inter',
                              color: Colors.black87)),
                      SizedBox(width: width * 0.01),
                      const Icon(Icons.pets, color: Colors.black),
                    ]),
                  ],
                ),
                SizedBox(width: width * 0.05),
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: width * 0.002,
                      ),
                    ),
                    child: SfSlider(
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      min: 0,
                      max: 5,
                      stepSize: 1,
                      showLabels: true,
                      showDividers: true,
                      interval: 1,
                      value: _rating,
                      onChanged: (newRating) {
                        setState(() => _rating = newRating);
                      },
                      labelPlacement: LabelPlacement.onTicks,
                      labelFormatterCallback:
                          (dynamic actualValue, String formattedText) {
                        switch (actualValue.toInt()) {
                          case 0:
                            return "0";
                          case 1:
                            return "1";
                          case 2:
                            return "2";
                          case 3:
                            return "3";
                          case 4:
                            return "4";
                          case 5:
                            return "5";
                        }
                        return actualValue.toInt();
                      },
                    ),
                  ),
                  
                ),

                SizedBox(height: height * 0.01),

                Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: const Text("How much did you finish?",
                      style: TextStyle(
                          fontSize: 17.1429,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                          color: Colors.black87)),
                ),

                // TO DO: change the value so that it corresponds to the rating of food waste!
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: width * 0.002,
                        ),
                      ),
                      child: SfSlider(
                        activeColor: Colors.green,
                        inactiveColor: Colors.grey,
                        min: 0,
                        max: 100,
                        stepSize: 20,
                        showLabels: true,
                        showDividers: true,
                        interval: 20,
                        value: _amount_finished,
                        onChanged: (newRating) {
                          setState(() => _amount_finished = newRating);
                        },
                        labelPlacement: LabelPlacement.onTicks,
                        labelFormatterCallback:
                            (dynamic actualValue, String formattedText) {
                          switch (actualValue.toInt()) {
                            case 0:
                              return "0%";
                            case 20:
                              return "";
                            case 40:
                              return "";
                            case 60:
                              return "";
                            case 80:
                              return "";
                            case 100:
                              return "100%";
                          }
                          return actualValue.toInt();
                        },
                      )),
                ),
                SizedBox(height: height * 0.03),
                SizedBox(width: width * 0.05),
                Padding(
                  padding: EdgeInsets.all(width * 0.03),
                  child: const Text("Leave a comment!",
                      style: TextStyle(
                          fontSize: 17.1429,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                          color: Colors.black87)),
                ),

                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: TextField(
                    controller: _commentController,
                    maxLines: 3,
                    onChanged: (value) {
                      _comment = value;
                    },
                    decoration: const InputDecoration(
                      hintText: "Type here",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Padding(
                  padding: EdgeInsets.all(width * 0.03),
                  child: const Text("Photo Upload",
                      style: TextStyle(
                          fontSize: 17.1429,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                          color: Colors.black87)),
                ),
                SizedBox(height: height * 0.03),

                Center(
                  child: Container(
                    child: TextButton(
                      child: Image.asset('assets/images/Camera.png'),
                      onPressed: _takeAndUploadPicture,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.01),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF006400)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(Size.zero),
                    ),
                    onPressed: () {
                      _submitReview();
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text('Get Started'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

//screeen that displays all the comments
class CommentScreen extends StatelessWidget {
  final FoodItem foodItem;

  CommentScreen({required this.foodItem});
  var comments = [];
  var ratings = [];
  var posted_dates = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comments:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('food')
                    .doc(formattedDate)
                    .collection(foodItem.name)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final comments = snapshot.data!.docs
                        .map((doc) => doc['comment' as String])
                        .toList();

                    final ratings = snapshot.data!.docs
                        .map((doc) => doc['rating'] as double)
                        .toList();

                    final posted_dates = snapshot.data!.docs
                        .map((doc) => doc['posted_date'] as String)
                        .toList();

                    if (comments.isEmpty) {
                      return const Center(
                        child: Text('No comments yet.'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: ratings.length,
                        itemBuilder: (context, index) {
                          final rating = ratings[index];
                          final comment = comments[index];
                          final postedDate = posted_dates[index];
                          return ListTile(
                            title: Text(
                              'User ${index + 1}',
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    for (int i = 0; i < rating; i++)
                                      Icon(
                                        Icons.pets,
                                        color: Color(0xFF3B7D3C),
                                        size: 16,
                                      ),
                                    SizedBox(width: width * 0.1),
                                    Spacer(),
                                    Text(postedDate),
                                  ],
                                ),
                                Text(comment),
                                SizedBox(height: height * 0.01),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//When user swipes to the left, this screen containing the food's nutrition is displayed
class NutritionScreen extends StatelessWidget {
  final FoodItem foodItem;

  NutritionScreen({required this.foodItem});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: height,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Nutritional Detail",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),

          // make space
          SizedBox(
            height: height * 0.02,
          ),
          const Text(
            "About",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.green),
          ),
          SizedBox(
            height: height * 0.01,
          ),

          Text(
            foodItem.description ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: height * 0.03),
          const Text(
            "Nutritional Value",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
          ),

          SizedBox(height: height * 0.01),

          Row(
            children: [
              Text(
                'Carbs',
                style: const TextStyle(fontSize: 12),
              ),
              SizedBox(width: width * 0.50),
              Text(
                '${foodItem.carbs?.toString() ?? ''}g',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),

          Row(
            children: [
              Text(
                'Protiens',
                style: const TextStyle(fontSize: 12),
              ),
              SizedBox(width: width * 0.47),
              Text(
                '${foodItem.protiens?.toString() ?? ''}g',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),

          Row(
            children: [
              Text(
                'Saturated Fats',
                style: const TextStyle(fontSize: 12),
              ),
              SizedBox(width: width * 0.39),
              Text(
                '${foodItem.satFat?.toString() ?? ''}g',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),

          Row(
            children: [
              Text(
                'Sugar',
                style: const TextStyle(fontSize: 12),
              ),
              SizedBox(width: width * 0.5),
              Text(
                '${foodItem.sugars?.toString() ?? ''}g',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),

          Row(
            children: [
              Text(
                'Calories',
                style: const TextStyle(fontSize: 12),
              ),
              SizedBox(width: width * 0.455),
              Text(
                '${foodItem.cals?.toString() ?? ''}g',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
        ],
      ),
    ));
  }
}

//The main widget that holds all 3 screens of the swipeup feature
class ReviewScreens extends StatefulWidget {
  final FoodItem foodItem;
  final String diningHall;
  final String mealTime;
  ReviewScreens(
      {required this.foodItem,
      required this.diningHall,
      required this.mealTime});

  @override
  State<ReviewScreens> createState() => _ReviewScreensState();
}

class _ReviewScreensState extends State<ReviewScreens> {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CupertinoNavigationBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 30),
            child: IconTheme(
              data: IconThemeData(size: 35.0),
              child: IconButton(
                icon: Icon(CupertinoIcons.back),
                color: Color(0xff3B7D3C),
                onPressed: () {
                  _pageController.previousPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                },
              ),
            ),
          ),
          middle: Column(
            children: [
              Image.asset(
                'assets/images/rectangle.png',
                width: width * 0.13,
                height: kTextTabBarHeight * 0.7,
              ),
            ],
          ),
          trailing: Padding(
            padding: EdgeInsets.only(right: 30),
            child: IconTheme(
              data: IconThemeData(size: 32.0),
              child: IconButton(
                icon: Icon(CupertinoIcons.forward),
                color: Color(0xff3B7D3C),
                onPressed: () {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                },
              ),
            ),
          )),
      body: PageView(
        controller: _pageController,
        children: [
          NutritionScreen(foodItem: widget.foodItem),
          ReviewSurveyScreen(
              foodItem: widget.foodItem,
              diningHall: widget.diningHall,
              mealTime: widget.mealTime),
          CommentScreen(foodItem: widget.foodItem),
        ],
        onPageChanged: (index) {},
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return CupertinoNavigationBar(
      leading: Icon(CupertinoIcons.back),
      middle: Column(
        children: [
          Image.asset(
            'assets/images/rectangle.png',
            width: width * 0.13,
            height: kTextTabBarHeight * 0.7,
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(CupertinoIcons.forward),
        onPressed: () {},
      ),
    );
  }
}
