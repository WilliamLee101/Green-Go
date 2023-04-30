import 'package:flutter/material.dart';
import 'package:green_n_go/utils/navBar.dart';
import 'package:green_n_go/utils/globals.dart' as globals;

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    globals.selectedIndex = 2;
    return Scaffold(body: Text("notthing"), bottomNavigationBar: NavBar());
  }
}
