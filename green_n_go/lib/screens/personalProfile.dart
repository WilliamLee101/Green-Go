import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_n_go/screens/home_page.dart';
import 'package:green_n_go/screens/signInPage.dart';
import 'package:green_n_go/screens/user_setup.dart';
import 'package:green_n_go/utils/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_n_go/utils/navBar.dart';
import 'package:green_n_go/utils/globals.dart' as globals;

bool isVegetarian = false;
bool isVegan = false;
bool isGluten = false;

class ProfileView extends StatelessWidget {
  Future<void> signOut() async {
    Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    globals.selectedIndex = 1;

// profile page styling
    if (user != null) {
      return const UserProfile();
    } else {
      return const GuestProfile();
    }
  }
}

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;
    checkPreferences();
    return Scaffold(
        bottomNavigationBar: const NavBar(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff3B7D3C),
          toolbarHeight: .1 * height,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))),
          title: const Text(
            'My Profile',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: height * 0.035),
            Row(
              children: [
                SizedBox(width: width * 0.05),
                Row(
                  children: [
                    Image(
                      image: NetworkImage(user!.photoURL!),
                      width: 100.0,
                      height: 100.0,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${user.displayName}',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(width: width * 0.05),
              const Text(
                "Dietary Preferences",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: width * 0.05),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("No Preferences"),
                    isVegan
                        ? const Text("Vegan",
                            style: TextStyle(
                                color: Color(0xff3B7D3C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                        : const Text("Vegan",
                            style: TextStyle(
                                color: Color(0xffA4A4A4), fontSize: 18)),
                    isVegetarian
                        ? const Text("Vegetarian",
                            style: TextStyle(
                                color: Color(0xff3B7D3C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                        : const Text("Vegetarian",
                            style: TextStyle(
                                color: Color(0xffA4A4A4), fontSize: 18)),
                    isGluten
                        ? const Text("Gluten-Free",
                            style: TextStyle(
                                color: Color(0xff3B7D3C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                        : const Text("Gluten-Free",
                            style: TextStyle(
                                color: Color(0xffA4A4A4), fontSize: 18)),
                    isHalal
                        ? const Text("Halal",
                            style: TextStyle(
                                color: Color(0xff3B7D3C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                        : const Text("Halal",
                            style: TextStyle(
                                color: Color(0xffA4A4A4), fontSize: 18)),
                  ],
                ),
              ],
            ),
            SizedBox(height: height * 0.05),
            Row(
              children: [
                SizedBox(width: width * 0.05),
                const Text(
                  "Activities",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff3B7D3C)),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: width * 0.05),
                const Text("Terrier type"),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: Color(0xffE6E6E6)),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/img47.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                  Text("Passionate Foodie")
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                SizedBox(width: width * 0.03),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("  My Account",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserSetup()),
                                (_) => false);
                          },
                          child: const Text(
                            "Change Preferences",
                            style: TextStyle(fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {
                            signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (_) => false);
                          },
                          child: const Text(
                            "Sign Out",
                            style: TextStyle(
                                color: Color(0xffFF0000), fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class GuestProfile extends StatefulWidget {
  const GuestProfile({super.key});

  @override
  State<GuestProfile> createState() => _GuestProfileState();
}

class _GuestProfileState extends State<GuestProfile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: const NavBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.5),
              const Text("You are not logged in"),
              TextButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await signInWithGoogle();
                    if (globals.firstTimeLogin == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserSetup()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  } catch (e) {
                    print(e);
                    // Show error message to user
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
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
        ],
      ),
    );
  }
}

//Check database for user preferences
void checkPreferences() {
  final user = FirebaseAuth.instance.currentUser;
  String userID = user!.uid;
  print("userID: " + userID);

  CollectionReference userInfoRef =
      FirebaseFirestore.instance.collection('users');
  DocumentReference userInfoUpdateRef = userInfoRef.doc(userID);
  userInfoUpdateRef.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      isVegetarian = data['isVegetarian'];
      isVegan = data['isVegan'];
      isGluten = data['isGluten'];
      return true;
    }
  });
}
