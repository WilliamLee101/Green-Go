import 'package:flutter/material.dart';

class West extends StatefulWidget {
  const West({super.key});

  @override
  State<West> createState() => _WestState();
}

class _WestState extends State<West> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('West Menu'),
      ),
    );
  }
}
