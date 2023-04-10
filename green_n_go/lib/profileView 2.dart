import 'package:flutter/material.dart';

class profileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'My Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/terrier_logo.png',
                width: 30.0,
                height: 30.0,
              ),
              SizedBox(
                  width: 8), // Add some spacing between the image and the text
            ],
          ),
        ),
        body: ElevatedButton(onPressed: () {}, child: Text("Sign out")));
  }
}
