import 'package:flutter/material.dart';
import 'package:green_n_go/screens/user_setup.dart';
import 'package:green_n_go/utils/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_n_go/utils/navBar.dart';

class ProfileView extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      Auth().signOut();
    }

    double screenHeight = MediaQuery.of(context).size.height;
// profile page styling
    if (user != null) {
      return Scaffold(
          bottomNavigationBar: NavBar(),
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
                '${user?.displayName}',
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              )
            ]),
            Align(
                alignment: Alignment.topLeft,
                child: Column(children: [
                  // make space
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20.0),
                    child: const Text(
                      'Dietary Preference',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // make space
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20.0),
                    child: const Text(
                      'No Preference',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20.0),
                    child: const Text(
                      'Vegan',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20.0),
                    child: const Text(
                      'Kosher',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20.0),
                    child: const Text(
                      'Gluten-free',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ])),
            // make space
            const SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(right: 20.0),
                  child: const Text(
                    'Activites',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )),
            // make space
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(right: 20.0),
                  child: const Text(
                    'Your Terrier Type',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(right: 20.0),
                  child: const Text(
                    'TERRIER PERSONA',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(right: 20.0),
                  child: const Text(
                    'My Account',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),

            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                    onPressed: signOut,
                    child: const Text("Log out",
                        style: const TextStyle(color: Colors.red)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white))))
          ]));
    } else {
      return Scaffold(
        bottomNavigationBar: NavBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.5),
            Text("You are not logged in"),
            TextButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await signInWithGoogle();
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
                    MaterialStateProperty.all<Color>(const Color(0xff3B7D3C)),
              ),
              child: const Text('  Sign In with Google Account  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      );
    }
  }
}
