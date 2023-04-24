import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_n_go/screens/marciano.dart';
import 'package:green_n_go/screens/warren.dart';
import 'package:green_n_go/screens/west.dart';

// importing of green
final Color darkGreen = Color(0xFF3B7D3C);

// Landing page Styling 
class HomePage extends StatelessWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.25, 0.1],
            colors: [darkGreen, Colors.white],
          )),
          child: Column(
              // centering page
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // insert profile icon
                Column(children: [
                  Row(
                    // aligning the text on the page
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                          child: Text('Welcome, ',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                              textAlign: TextAlign.center)),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          Text(
                            '${user?.displayName}!',
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          )
                        ],
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
                    alignment: Alignment.topLeft,
                    child: Column(children: const [
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 12.1429,
                          color: Colors.green,
                        ),
                      ),
                      // text and stylying for select dining halls
                      Text(
                        'Select Dining Hall',
                        style: TextStyle(
                            fontSize: 17.1429, fontWeight: FontWeight.bold),
                      )
                    ])),

                // make space
                const SizedBox(
                  height: 10,
                ),
// Warren
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const Warren();
                      }),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/warren.png',
                            height: 100, width: 100, fit: BoxFit.fill),
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
                                  color: Colors.green),
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
                                      fontSize: 12, color: Colors.grey),
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
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const Marciano();
                      }),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/marciano.png',
                            height: 100, width: 100, fit: BoxFit.fill),
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
                                  color: Colors.green),
                            ),
                            const Text(
                              'Located in East Campus',
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
                                      fontSize: 12, color: Colors.grey),
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
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const West();
                      }),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/west.png',
                            height: 100, width: 100, fit: BoxFit.fill),
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
                                  color: Colors.green),
                            ),
                            const Text(
                              'Located in West Campus',
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
                                      fontSize: 12, color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
