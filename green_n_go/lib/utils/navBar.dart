import 'package:flutter/material.dart';
import 'package:green_n_go/screens/home_page.dart';
import '../main.dart';
import '../screens/personalProfile.dart';
import '../screens/rewards_page.dart';
import 'package:green_n_go/utils/globals.dart' as globals;

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<Widget> _pages = <Widget>[
    HomePage(),
    RewardsPage(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    int temp = globals.selectedIndex;
    setState(() {
      globals.selectedIndex = index;
    });
    if (globals.selectedIndex != temp) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => _pages[index],
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 181, 179, 179).withOpacity(0.7),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 6),
        ),
      ]),
      child: BottomNavigationBar(
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
            icon: Icon(Icons.emoji_events),
            label: 'Rewards',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: globals.selectedIndex,
      ),
    );
  }
}
