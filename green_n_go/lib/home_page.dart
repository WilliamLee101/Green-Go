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
            const Text('GREEN N GO',style: TextStyle(fontSize: 50)),
            const SizedBox(height: 16),
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
