import 'package:flutter/material.dart';

class Warren extends StatefulWidget {
  const Warren({super.key});

  @override
  State<Warren> createState() => _WarrenState();
}

class _WarrenState extends State<Warren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warren Menu'),
      ),
    );
  }
}
