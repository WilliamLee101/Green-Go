import 'package:flutter/material.dart';
import 'package:green_n_go/auth.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      Auth().signOut();
    }

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'My Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 200),
              Image.asset(
                'assets/images/terrier_logo.png',
                width: 30.0,
                height: 30.0,
              ),
              // Add some spacing between the image and the text
            ],
          ),
        ),
        body: Column(children: [
          Row(children: [
            Image.asset(
              'assets/images/profileicon.png',
              width: 100.0,
              height: 100.0,
            ),
            SizedBox(width: 16),
            Text(
              'User',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          ]),
          Text(
            'Dietary Preference',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            textAlign: TextAlign.end,
          ),
          ElevatedButton(onPressed: signOut, child: const Text("Sign out"))
        ]));
  }
}
