import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_n_go/utils/navBar.dart';
import 'package:green_n_go/utils/globals.dart' as globals;
import 'package:green_n_go/utils/navBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  int numCommentsMade = 0;
  int numPlatesFinished = 0;
  bool signIn = true;
  int badge_comment_made = 0;
  int badge_finish_made = 0;

  @override
  void initState() {
    super.initState();
    // get users' info
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userID = user.uid;
      CollectionReference userInfoRef =
          FirebaseFirestore.instance.collection('users');
      DocumentReference userInfoUpdateRef = userInfoRef.doc(userID);
      userInfoUpdateRef.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          numCommentsMade = data['num_comments_made'];
          numPlatesFinished = data['num_plates_finished'];

          badge_comment_made = (numCommentsMade / 5).toInt();
          badge_finish_made = (numPlatesFinished / 5).toInt();

          setState(() {}); // trigger rebuild to update UI
        } else {
          print('Document does not exist on the database');
        }
      });
    } else {
      signIn = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    globals.selectedIndex = 1;

    if (signIn == true) {
      return Scaffold(
          appBar: AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Rewards',
                style: TextStyle(fontSize: 27),
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff3B7D3C),
            toolbarHeight: .1 * height,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffC6D9B7),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/triumph.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 5),
                            Text(
                              (badge_comment_made + badge_finish_made)
                                  .toString(),
                              style: TextStyle(
                                color: Color(0xff3B7D3C),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text("Badges",
                          style: TextStyle(
                              color: Color(0xff3B7D3C), fontSize: 13)),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      int numCommentsMade = data['num_comments_made'] ?? 0;

                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffC6D9B7),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/comment.png',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  numCommentsMade.toString(),
                                  style: TextStyle(
                                    color: Color(0xff3B7D3C),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text("Reviews",
                              style: TextStyle(
                                  color: Color(0xff3B7D3C), fontSize: 13)),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      int numPlatesFinished = data['num_plates_finished'] ?? 0;

                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffC6D9B7),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/bowl.png',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  numPlatesFinished.toString(),
                                  style: TextStyle(
                                    color: Color(0xff3B7D3C),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text("Meals",
                              style: TextStyle(
                                  color: Color(0xff3B7D3C), fontSize: 13)),
                        ],
                      );
                    },
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              SizedBox(height: 15),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Achievements",
                      style: TextStyle(color: Color(0xff3B7D3C), fontSize: 13),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Earned Badges",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    numCommentsMade >= 5
                        ? 'assets/images/terrier_badge1.png'
                        : 'assets/images/terrier_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                  SizedBox(width: 13),
                  Image.asset(
                    numCommentsMade >= 10
                        ? 'assets/images/terrier_badge2.png'
                        : 'assets/images/terrier_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                  SizedBox(width: 13),
                  Image.asset(
                    numCommentsMade >= 15
                        ? 'assets/images/terrier_badge3.png'
                        : 'assets/images/terrier_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    numCommentsMade >= 20
                        ? 'assets/images/comment_badge1.png'
                        : 'assets/images/comment_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                  SizedBox(width: 13),
                  Image.asset(
                    numCommentsMade >= 25
                        ? 'assets/images/comment_badge2.png'
                        : 'assets/images/comment_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                  SizedBox(width: 13),
                  Image.asset(
                    numCommentsMade >= 30
                        ? 'assets/images/comment_badge3.png'
                        : 'assets/images/comment_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    numPlatesFinished >= 5
                        ? 'assets/images/tool_badge1.png'
                        : 'assets/images/tool_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                  SizedBox(width: 13),
                  Image.asset(
                    numPlatesFinished >= 10
                        ? 'assets/images/tool_badge2.png'
                        : 'assets/images/tool_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                  SizedBox(width: 13),
                  Image.asset(
                    numPlatesFinished >= 15
                        ? 'assets/images/tool_badge3.png'
                        : 'assets/images/tool_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    numPlatesFinished >= 20
                        ? 'assets/images/plate_badge1.png'
                        : 'assets/images/plate_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                  SizedBox(width: 13),
                  Image.asset(
                    numPlatesFinished >= 25
                        ? 'assets/images/plate_badge2.png'
                        : 'assets/images/plate_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                  SizedBox(width: 13),
                  Image.asset(
                    numPlatesFinished >= 30
                        ? 'assets/images/plate_badge3.png'
                        : 'assets/images/plate_badge0.png',
                    width: width * 0.27,
                    height: width * 0.27,
                  ),
                ],
              ),
            ],
          )),
          bottomNavigationBar: const NavBar());
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Rewards',
                style: TextStyle(fontSize: 27),
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff3B7D3C),
            toolbarHeight: .1 * height,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
          body: Center(
            child: Text(
              "Oops! You have to login first.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
          bottomNavigationBar: const NavBar());
    }
  }
}
