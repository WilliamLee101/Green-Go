import 'package:flutter/material.dart';
import 'package:green_n_go/marciano.dart';
import 'package:green_n_go/warren.dart';
import 'package:green_n_go/west.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                        style: TextStyle(fontSize: 28),
                        textAlign: TextAlign.right)),
                const Expanded(
                    child: Text(
                  ' Terrier!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
                Expanded(
                  child: Image.asset(
                    'assets/images/profileicon.png',
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
              ],
            ),

            
            // add the dvider
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            // make space
            const SizedBox(
              height: 10,
            ),

            // text and stylying for select dining halls
            const Text('Select Dining Hall',
                style: TextStyle(fontSize: 17.1429)),

            // make space
            const SizedBox(
              height: 20,
            ),

            // insert Warren Dining image
            Image.asset('assets/images/warren.png',
                height: 100, width: null, fit: BoxFit.fill),

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
                height: 100, width: null, fit: BoxFit.fill),

            const SizedBox(height: 16), // Add some space between the buttons

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
                height: 100, width: null, fit: BoxFit.fill),

            const SizedBox(height: 16), // Add some space between the buttons

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
          ],
        ),
      ),
      
    );
  }
}
