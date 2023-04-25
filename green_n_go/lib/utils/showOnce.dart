import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//This utility is used to only show the intro screens the first time the user opens the download from a download. Otherwise will redirect users
class ShowOnceUtil extends StatefulWidget {
  static const String id = "/ShowOnceUtil";

  const ShowOnceUtil({super.key});
  @override
  _ShowOnce createState() => _ShowOnce();
}

class _ShowOnce extends State<ShowOnceUtil> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      _handleStartScreen();
    } else {
      await prefs.setBool('seen', true);
      Navigator.pushNamed(context, '/intro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future<void> _handleStartScreen() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/signIn');
    }
  }
}
