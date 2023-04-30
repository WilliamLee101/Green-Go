import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../classes/foodItem.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

//This is the review screen widget that is displayed when users want to create a review
class ReviewSurveyScreen extends StatefulWidget {
  final FoodItem foodItem;
  final String diningHall;

  ReviewSurveyScreen({required this.foodItem, required this.diningHall});

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
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true, // remove the extra argument here
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Rate your experience",
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [
                  Text("How did you like it?",
                      style: TextStyle(
                          fontSize: 17.1429,
                          fontFamily: 'Inter',
                          color: Colors.black87)),
                  SizedBox(width: 5),
                  Icon(Icons.pets, color: Colors.black),
                ]),

                const SizedBox(height: 8.0),

                SfSlider(
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

                const SizedBox(height: 16.0),
                const Text("How much did you finish?",
                    style: TextStyle(
                        fontSize: 17.1429,
                        fontFamily: 'Inter',
                        color: Colors.black87)),
                const SizedBox(height: 8.0),

                // TO DO: change the value so that it corresponds to the rating of food waste!
                SfSlider(
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
                ),

                const SizedBox(height: 15.0),

                const Text("Leave a comment!",
                    style: TextStyle(
                        fontSize: 17.1429,
                        fontFamily: 'Inter',
                        color: Colors.black87)),
                const SizedBox(height: 8.0),
                TextField(
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
                SizedBox(height: 10.0),
                const Text("Photo Upload",
                    style: TextStyle(
                        fontSize: 17.1429,
                        fontFamily: 'Inter',
                        color: Colors.black87)),
                SizedBox(height: 8.0),

                Center(
                  child: Container(
                    child: TextButton(
                      child: Image.asset('assets/images/Camera.png'),
                      onPressed: _takeAndUploadPicture,
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Comments:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
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
                                    SizedBox(width: 8),
                                    Spacer(),
                                    Text(postedDate),
                                  ],
                                ),
                                Text(comment),
                                SizedBox(height: 8),
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nutrition Details'),
        ),
        body: Container(
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
                foodItem.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                foodItem.description ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                '${foodItem.carbs?.toString() ?? ''} carbs',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${foodItem.protiens?.toString() ?? ''} protiens',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '${foodItem.satFat?.toString() ?? ''} satFat',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '${foodItem.sugars?.toString() ?? ''} sugars',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '${foodItem.cals?.toString() ?? ''} cals',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ));
  }
}

//The main widget that holds all 3 screens of the swipeup feature
class ReviewScreens extends StatefulWidget {
  final FoodItem foodItem;
  final String diningHall;
  ReviewScreens({required this.foodItem, required this.diningHall});

  @override
  State<ReviewScreens> createState() => _ReviewScreensState();
}

class _ReviewScreensState extends State<ReviewScreens> {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _pageController,
        children: [
          NutritionScreen(foodItem: widget.foodItem),
          ReviewSurveyScreen(
              foodItem: widget.foodItem, diningHall: widget.diningHall),
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
