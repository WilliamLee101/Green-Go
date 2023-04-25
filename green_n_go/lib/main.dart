import 'package:flutter/material.dart';
import 'package:green_n_go/screens/intro_screen.dart';
import 'package:green_n_go/screens/personalProfile.dart';
import 'package:green_n_go/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:green_n_go/screens/signInPage.dart';
import 'package:green_n_go/utils/showOnce.dart';
import 'package:green_n_go/utils/firebase_options.dart';
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
      home: ShowOnceUtil(),
      routes: {
        '/home': (context) => const RootPage(),
        '/intro': (context) => const IntroScreen(),
        '/signIn': (context) => const SignInPage(),
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

// navigation bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HomePage(),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.blueGrey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'assets/images/terrier_logo.png',
                  width: 22.0,
                  height: 22.0,
                ),
              ),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Rewards',
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ));
  }
}
