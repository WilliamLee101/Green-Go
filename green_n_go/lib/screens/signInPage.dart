import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_n_go/screens/user_setup.dart';
import 'package:green_n_go/utils/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool loggedIn = false;
  int num_comments_made = 0;
  int num_plates_finished = 0;

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
      // Display error message to user
    }
  }

  User? _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        if (user.uid != users.doc(user.uid).get()) {
          users.doc(user.uid).set({
            'name': user.displayName,
            'email': user.email,
            'photo': user.photoURL,
            "num_comments_made": num_comments_made,
            "num_plates_finished": num_plates_finished
          });
        }
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 300,
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: width * 0.3,
                    width: width * 0.3,
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  const Text("Welcome, Terrier!",
                      style: TextStyle(fontSize: 15)),
                  const Text(
                    "Rhett’y to eat?",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3A7D3C)),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential =
                            await signInWithGoogle();
                        if (userCredential.user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserSetup()));
                        } else {
                          // Show error message to user
                        }
                      } catch (e) {
                        print(e);
                        // Show error message to user
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff3B7D3C)),
                    ),
                    child: const Text('  Sign In with Google Account  ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextButton(
                    onPressed: () {
                      signOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              color: Color(0xff3B7D3C), width: 2),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text(
                      '           Continue as Guest           ',
                      style: TextStyle(
                        color: Color(0xff3B7D3C),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
