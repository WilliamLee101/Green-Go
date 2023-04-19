import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_n_go/screens/user_setup.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

void signOut() {
  FirebaseAuth.instance.signOut();
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loggedIn = false;

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
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        if (user.uid != users.doc(user.uid).get()) {
          users.doc(user.uid).set({
            'name': user.displayName,
            'email': user.email,
            'photo': user.photoURL,
            'comment': 'hello'
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
                  SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text("Welcome, Terrier!", style: TextStyle(fontSize: 15)),
                  Text(
                    "Rhett’y to eat?",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(
                    height: 220,
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: Text('  Sign In with Google Account  ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
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
                          side: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      '           Continue as Guest           ',
                      style: TextStyle(
                        color: Colors.green,
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
