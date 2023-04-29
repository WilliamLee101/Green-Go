import 'package:flutter/material.dart';
import 'package:green_n_go/screens/intro_screen.dart';
import 'package:green_n_go/screens/personalProfile.dart';
import 'package:green_n_go/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:green_n_go/screens/rewards_page.dart';
import 'package:green_n_go/screens/signInPage.dart';
import 'package:green_n_go/utils/navBar.dart';
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
      home: IntroScreen(),
      routes: {
        '/home': (context) => HomePage(),
        '/intro': (context) => const IntroScreen(),
        '/signIn': (context) => const SignInPage(),
        '/rewards': (context) => const RewardsPage()
      },
    );
  }
}
