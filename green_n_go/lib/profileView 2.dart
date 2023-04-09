import 'package:flutter/material.dart';

class profileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: ElevatedButton(onPressed: () {}, child: Text("Sign out")));
  }
}
