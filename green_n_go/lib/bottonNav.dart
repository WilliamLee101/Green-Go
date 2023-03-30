import 'package:flutter/material.dart';
import 'package:green_n_go/profilePage.dart';

import 'main.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({super.key});
  
int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[MyApp(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }
  
}