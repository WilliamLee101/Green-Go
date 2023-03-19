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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // styling for welcome, terriers!
            const Text('Welcome,', style: TextStyle(fontSize: 28)),
            const Text(' Terrier!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

            // insert profile icon
            Image.asset('assets/images/profileicon.png',
                height: 100, width: null, fit: BoxFit.fill),

            // make space
            const SizedBox(
              height: 20,
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
              child: const FittedBox(child:Text('Warren', style: TextStyle(fontSize: 30),)),
            ),
            const SizedBox(height: 16), // Add some space between the buttons
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Marciano();
                  }),
                );
              },
              child: const Text('Marciano',style: TextStyle(fontSize: 30)),
            ),
            const SizedBox(height: 16), // Add some space between the buttons
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const West();
                  }),
                );
              },
              child: const Text('West',style: TextStyle(fontSize: 30)),
            ),
            
          ],
        ),
      ),
    );
  }
}
