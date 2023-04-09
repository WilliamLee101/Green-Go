import 'package:flutter/material.dart';
import 'package:green_n_go/screens/marciano.dart';
import 'package:green_n_go/screens/warren.dart';
import 'package:green_n_go/screens/west.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.22, 0.1],
            colors: [Colors.green, Colors.white],
          )),
          child: Column(
              // centering page
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // insert profile icon
                Row(
                  // aligning the text on the page
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                        child: Text('Welcome,',
                            style: TextStyle(fontSize: 28, color: Colors.white),
                            textAlign: TextAlign.center)),
                    const Expanded(
                        child: Text(
                      ' Terrier!',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.left,
                    )),
                    Expanded(
                      child: Image.asset(
                        'assets/images/terrier_logo.png',
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                  ],
                ),
                // const Text(
                //   'Choose wisely and help others make informed decisions with your reviews.',
                //   style: TextStyle(fontSize: 17.1429, color: Colors.white),
                //   textAlign: TextAlign.left,
                // ),
                // make space
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 12.1429,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.left,
                ),
                // text and stylying for select dining halls
                const Text(
                  'Select Dining Hall',
                  style:
                      TextStyle(fontSize: 17.1429, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),

                // make space
                const SizedBox(
                  height: 20,
                ),

                // insert Warren Dining image
                Image.asset('assets/images/warren.png',
                    height: 100, width: 100, fit: BoxFit.fill),

                // buttons
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const Warren();
                      }),
                    );
                  },

                  // styling and text for 'Warren'
                  child: const FittedBox(
                      child: Text(
                    'Warren',
                    style: TextStyle(
                        fontSize: 17.1429,
                        fontFamily: 'Inter',
                        color: Colors.black87),
                  )),
                ),

                // insert Marciano Dining image
                Image.asset('assets/images/marciano.png',
                    height: 100, width: 100, fit: BoxFit.fill),

                const SizedBox(
                    height: 16), // Add some space between the buttons

                // button for Marciano
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const Marciano();
                      }),
                    );
                  },

                  // styling and text for 'Marciano'
                  child: const Text('Marciano',
                      style: TextStyle(
                          fontSize: 17.1429,
                          fontFamily: 'Inter',
                          color: Colors.black87)),
                ),

                // insert West Dining image
                Image.asset('assets/images/west.png',
                    height: 100, width: 100, fit: BoxFit.fill),

                const SizedBox(
                    height: 16), // Add some space between the buttons

                // button for west
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const West();
                      }),
                    );
                  },

                  // styling and text for 'West'
                  child: const Text('West',
                      style: TextStyle(
                          fontSize: 17.1429,
                          fontFamily: 'Inter',
                          color: Colors.black87)),
                ),
              ]),
        ),
      ),
    );
  }
}
