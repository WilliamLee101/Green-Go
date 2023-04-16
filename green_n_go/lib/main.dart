import 'package:flutter/material.dart';
import 'package:green_n_go/intro_screen.dart';
import 'package:green_n_go/profileView.dart';
import 'package:green_n_go/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:green_n_go/profilePage.dart';
import 'package:green_n_go/screens/login_register_page.dart';
import 'package:green_n_go/screens/user_setup.dart';
import 'package:green_n_go/widgetTree.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseDatabase database = FirebaseDatabase.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Inter"),
      home: const IntroScreen(),
      routes: {
        '/login': (context) => const WidgetTree(),
        '/home': (context) => const RootPage(),
      },
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[RootPage(), ProfileView()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HomePage(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dining),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ));
  }
}
