import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_n_go/screens/marciano.dart';
import 'package:green_n_go/screens/warren.dart';
import 'package:green_n_go/screens/west.dart';
import 'package:green_n_go/utils/navBar.dart';
import 'package:green_n_go/utils/globals.dart' as globals;

// importing of green
final Color darkGreen = Color(0xFF3B7D3C);

// Landing page Styling
class HomePage extends StatelessWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;
    globals.selectedIndex = 0;
    return Scaffold(
      bottomNavigationBar: const NavBar(),
      body: Center(
        child: Stack(
          children: [
            Container(
              height: 0.2 * height,
              decoration: const BoxDecoration(
                color: Color(0xff3B7D3C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            Container(
              height: height,
              width: width,
              child: Column(
                // centering page
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // insert profile icon
                  Column(children: [
                    Row(
                      // aligning the text on the page
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 0.05 * width,
                        ),
                        const Text('Welcome, ',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                            textAlign: TextAlign.center),
                        Text(
                          user?.displayName == null
                              ? 'Terrier!'
                              : '${user?.displayName}!',
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/images/terrier_logo.png',
                            width: 30.0,
                            height: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ]),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 0.05 * width,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            // text and stylying for select dining halls
                            Text(
                              "Location",
                              style: TextStyle(
                                  color: Color(0xff3B7D3C), fontSize: 13),
                            ),
                            Text(
                              'Select Dining Hall',
                              style: TextStyle(
                                  fontSize: 17.1429,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  // make space
                  const SizedBox(
                    height: 10,
                  ),
                  // Warren
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return Warren();
                          },
                          transitionDuration: Duration(milliseconds: 300),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            var begin = Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.2,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16), // 50% of the width and height
                              child: Image.asset(
                                'assets/images/warren.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Warren',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3B7D3C)),
                              ),
                              const Text(
                                'Located in Central Campus',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 10,
                                  ),
                                  Text(
                                    '700 Commonwealth Ave, Boston, MA 02215',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add some space between the buttons

                  // Marciano
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return Marciano();
                          },
                          transitionDuration: Duration(milliseconds: 300),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            var begin = Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },

                    //Marciano container
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.2,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16), // 50% of the width and height
                              child: Image.asset(
                                'assets/images/marciano.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Marciano',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3B7D3C)),
                              ),
                              const Text(
                                'Located In East Campus',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 10,
                                  ),
                                  Text(
                                    '100 Bay State Rd, Boston, MA 02215',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add some space between the buttons

                  // West
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return West();
                          },
                          transitionDuration: Duration(milliseconds: 300),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            var begin = Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },

                    //West container
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.2,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16), // 50% of the width and height
                              child: Image.asset(
                                'assets/images/west.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'West',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3B7D3C)),
                              ),
                              const Text(
                                'Located In West Campus',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 10,
                                  ),
                                  Text(
                                    '275 Babcock St, Boston, MA 02215',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
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
