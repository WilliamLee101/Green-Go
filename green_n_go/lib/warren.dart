import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Warren extends StatefulWidget {
  const Warren({super.key});

  @override
  State<Warren> createState() => _WarrenState();
}

class _WarrenState extends State<Warren> {
  DatabaseReference warrenRefBF = FirebaseDatabase.instance
      .ref()
      .child("updated_menu/2023-02-27/breakfast");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Warren Menu'),
        ),
        body: Container(
            height: double.infinity,
            child: FirebaseAnimatedList(
                query: warrenRefBF,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Center(
                    child: Container(decoration: BoxDecoration(color:Colors.white54, border: Border.all(color: Colors.black26)),child: Text(snapshot.child('item').value.toString())),
                  );
                }),
          ),
        );
  }
}
