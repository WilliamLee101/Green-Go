import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Warren extends StatefulWidget {
  const Warren({super.key});

  @override
  State<Warren> createState() => _WarrenState();
}

class _WarrenState extends State<Warren> {
  DatabaseReference warrenRef =
      FirebaseDatabase.instance.ref().child("updated_menu/2023-02-25/breakfast");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Warren Menu'),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
              query: warrenRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return Text('hello');
              }),
        ));
  }
}
