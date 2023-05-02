import 'package:flutter/material.dart';
import 'package:green_n_go/screens/signInPage.dart';

//Set of intro screens that users see when they first download the app
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  final List<Widget> _introScreens = const [
    IntroScreen1(),
    IntroScreen2(),
    IntroScreen3(),
    IntroScreen4(),
    SignInPage(),
  ];

  //Functions for indicating page, breakfast, lunch, dinner

  void _onPageChanged(int index) {
    setState(() {
      controller?.index = index;
    });
  }

  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: _introScreens.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _introScreens,
            ),
          ),
          TabPageSelector(
            controller: controller,
            color: Color(0xffD9D9D9),
            borderStyle: BorderStyle.none,
            selectedColor: Color(0xff3B7D3C),
          ),
          SizedBox(height: height * 0.015),
        ],
      ),
    );
  }
}

class AllIntros extends StatefulWidget {
  const AllIntros({super.key});

  @override
  State<AllIntros> createState() => _AllIntrosState();
}

class _AllIntrosState extends State<AllIntros> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.2),
              Image.asset(
                "assets/images/logo.png",
                height: width * 0.3,
                width: width * 0.3,
                fit: BoxFit.cover,
              ),
              SizedBox(height: height * 0.35),
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0, left: 35),
                  child: Image.asset(
                    'assets/images/Rhetty.png',
                    height: 65,
                    width: 187.5,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 25),
                  child: Image.asset(
                    'assets/images/TerrierTastes.png',
                    height: 125,
                    width: 250,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Image(
                  image: AssetImage('assets/images/rafiki.png'),
                  height: 276,
                  width: 370.41,
                ),
              ),
              Text(
                "Community",
                style: TextStyle(
                    height: 3,
                    fontSize: 30,
                    color: Color(0xFF3A7D3C),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Hungry for a better dining experience?\n Provide honest reviews to help you and\n other Terriers make informed choices.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffB3B3B3),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Image(
                  image: AssetImage('assets/images/cuate.png'),
                  height: 276,
                  width: 370.41,
                ),
              ),
              Text(
                "Sustainability",
                style: TextStyle(
                    height: 3,
                    fontSize: 30,
                    color: Color(0xFF3A7D3C),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Ready to make a difference?\n Feel empowered to choose wisely and\n participate in creating a sustainable future.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffB3B3B3),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class IntroScreen4 extends StatelessWidget {
  const IntroScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Image(
                  image: AssetImage('assets/images/rafiki2.png'),
                  height: 276,
                  width: 370.41,
                ),
              ),
              Text(
                "Motivation",
                style: TextStyle(
                    height: 3,
                    fontSize: 30,
                    color: Color(0xFF3A7D3C),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Join us in reducing food waste on campus, \n one plate at a time.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffB3B3B3),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter"),
              )
            ],
          )
        ],
      ),
    );
  }
}
