import 'package:flutter/material.dart';
import 'package:green_n_go/auth.dart';
import 'package:green_n_go/main.dart';
import 'package:green_n_go/profilePage.dart';
import 'package:green_n_go/profileView%202.dart';
import 'package:green_n_go/screens/home_page.dart';
import 'package:green_n_go/profileView.dart';

import 'package:green_n_go/screens/login_register_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RootPage();
          } else {
            return (const ProfilePage());
          }
        });
  }
}
