import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/foodItem.dart';

class ReviewSurveyScreen extends StatefulWidget {
  final FoodItem foodItem;
  ReviewSurveyScreen({required this.foodItem});

  @override
  _ReviewSurveyScreenState createState() => _ReviewSurveyScreenState();
}

class _ReviewSurveyScreenState extends State<ReviewSurveyScreen> {
  double _rating = 0.0;
  String _comment = '';

  void _submitReview() {
    CollectionReference reviews =
        FirebaseFirestore.instance.collection(widget.foodItem.name);
    // Submit review to backend
    Navigator.of(context).pop();
    reviews.add({
      'rating': _rating,
      'comment': _comment,
    }).then((value) => print('added'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Rate your experience: ${widget.foodItem.name}"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.pets, color: Colors.green),
            SizedBox(width: 5),
            const Text("How did you like it?",
                style: TextStyle(
                    fontSize: 17.1429,
                    fontFamily: 'Inter',
                    color: Colors.black87)),
            SizedBox(height: 8.0),
            Slider(
              activeColor: Colors.green,
              inactiveColor: Colors.black,
              thumbColor: Colors.green,
              value: _rating,
              onChanged: (newRating) {
                setState(() => _rating = newRating);
              },
              divisions: 5,
              label: "$_rating",
            ),
            SizedBox(height: 16.0),
            const Text("How much did you finish?",
                style: TextStyle(
                    fontSize: 17.1429,
                    fontFamily: 'Inter',
                    color: Colors.black87)),
            SizedBox(height: 8.0),

            // TO DO: change the value so that it corresponds to the rating of food waste!
            Slider(
              activeColor: Colors.green,
              inactiveColor: Colors.black,
              thumbColor: Colors.green,
              value: _rating,
              onChanged: (newRating) {
                setState(() => _rating = newRating);
              },
              divisions: 4,
              label: "$_rating",
            ),
            const Text("Leave a comment!",
                style: TextStyle(
                    fontSize: 17.1429,
                    fontFamily: 'Inter',
                    color: Colors.black87)),
            SizedBox(height: 8.0),
            TextField(
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF006400)),
                  ),
                  onPressed: () {
                    _submitReview();
                  },
                  child: Text("Submit")),
            ),
          ],
        ),
      ),
    );
  }
}
