import 'package:flutter/material.dart';
import 'foodItem.dart';

class ReviewSurveyScreen extends StatefulWidget {
  final FoodItem foodItem;

  ReviewSurveyScreen({required this.foodItem});

  @override
  _ReviewSurveyScreenState createState() => _ReviewSurveyScreenState();
}

class _ReviewSurveyScreenState extends State<ReviewSurveyScreen> {
  int _rating = 0;
  String _comment = '';

  void _submitReview() {
    // Submit review to backend
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate your experience: ${widget.foodItem.name}"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("How did you like it?", style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 8.0),
            Row(
              children: [
                _buildStar(1),
                _buildStar(2),
                _buildStar(3),
                _buildStar(4),
                _buildStar(5),
              ],
            ),
            SizedBox(height: 16.0),
            Text("How much did you finish?", style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 8.0),
            Row(
              children: [
                _buildStar(1),
                _buildStar(2),
                _buildStar(3),
                _buildStar(4),
                _buildStar(5),
              ],
            ),
            Text("Leave a comment!", style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 8.0),
            TextField(
              maxLines: 3,
              onChanged: (value) {
                _comment = value;
              },
              decoration: InputDecoration(
                hintText: "Enter your comment here",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _submitReview();
                },
                child: Text("Get Started"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar(int starCount) {
    return IconButton(
      icon: Icon(
        _rating >= starCount ? Icons.star : Icons.star_border,
        color: Colors.yellow[700],
      ),
      onPressed: () {
        setState(() {
          _rating = starCount;
        });
      },
    );
  }
}
