import 'package:flutter/material.dart';
import 'package:green_n_go/auth.dart';
class profileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      Auth().signOut();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: ElevatedButton(onPressed: signOut, child: Text("Sign out")));
  }
}
