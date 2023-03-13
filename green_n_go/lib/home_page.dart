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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Warren();
                  }),
                );
              },
              child: FittedBox(child:Text('Warren'),),
            ),
            const SizedBox(height: 16), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Marciano();
                  }),
                );
              },
              child: const Text('Marciano'),
            ),
            const SizedBox(height: 16), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const West();
                  }),
                );
              },
              child: const Text('West'),
            ),
            
          ],
        ),
      ),
    );
  }
}
