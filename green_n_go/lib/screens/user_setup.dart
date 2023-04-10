import 'package:flutter/material.dart';
import 'package:green_n_go/main.dart';
import 'package:green_n_go/screens/home_page.dart';
import 'package:green_n_go/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Global variables
var isKosher = false;
var isVegetarian = false;
var isVegan = false;
var isGluten = false;
final TextEditingController _controllerFirstName = TextEditingController();
final TextEditingController _controllerPassword = TextEditingController();
final TextEditingController _controllerEmail = TextEditingController();
final TextEditingController _controllerUserName = TextEditingController();

//Main screen for user to set up account
class UserSetup extends StatefulWidget {
  const UserSetup({super.key});

  @override
  State<UserSetup> createState() => _UserSetupState();
}

class _UserSetupState extends State<UserSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        children: [
          AccountDetails(),
          const Preferences(),
        ],
      ),
    );
  }
}

//Screen for user to enter account details

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  String? errorMessage = '';
  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm, $errorMessage');
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          _controllerEmail.text, _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 90,
              width: 90,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SizedBox(
                  width: 32,
                ),
                Text(
                  "Account Details",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            Container(
                height: 300,
                width: 500,
                child: Column(
                  children: [
                    _entryField("Full Name", _controllerFirstName),
                    SizedBox(
                      height: 20,
                    ),
                    _entryField("Email", _controllerEmail),
                    SizedBox(
                      height: 20,
                    ),
                    _entryField("Password", _controllerPassword),
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff3B7D3C),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff3B7D3C),
              ),
              child: SizedBox(
                  height: 40,
                  width: 187,
                  child: TextButton(
                    onPressed: () async {
                      if (_controllerFirstName.text.isEmpty ||
                          _controllerEmail.text.isEmpty ||
                          _controllerPassword.text.isEmpty) {
                        return;
                      }
                      try {
                        // Create user with email and password
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: _controllerEmail.text,
                          password: _controllerPassword.text,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Preferences()));
                        // Navigate to the next page on successful sign up
                      } on FirebaseAuthException catch (e) {
                        // Display error message and don't navigate to next page
                        String? errorMessage = e.message;
                        if (errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// Screen for user to select preferences

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  String? errorMessage = '';
  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm, $errorMessage');
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          _controllerEmail.text, _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Image.asset(
              'assets/images/logo.png',
              height: 90,
              width: 90,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: const [
                  Text(
                    "Dietary ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Text(
                    "Preferences",
                    style: TextStyle(fontSize: 28),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Select all that apply",
                  style: TextStyle(color: Color(0xff969696), fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width / 8),
              child: Container(
                  height: 300,
                  width: 500,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 40,
                                width: 110,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isKosher = !isKosher;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            isKosher
                                                ? const Color(0xff3A7D3C)
                                                : const Color(0xffB3B3B3)),
                                  ),
                                  child: const Text(
                                    "Kosher",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                height: 40,
                                width: 110,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isVegetarian = !isVegetarian;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            isVegetarian
                                                ? const Color(0xff3A7D3C)
                                                : const Color(0xffB3B3B3)),
                                  ),
                                  child: const Text("Vegetarian",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 60,
                              ),
                              SizedBox(
                                height: 40,
                                width: 110,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isVegan = !isVegan;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(isVegan
                                            ? const Color(0xff3A7D3C)
                                            : const Color(0xffB3B3B3)),
                                  ),
                                  child: const Text("Vegan",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                height: 40,
                                width: 110,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isGluten = !isGluten;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            isGluten
                                                ? const Color(0xff3A7D3C)
                                                : const Color(0xffB3B3B3)),
                                  ),
                                  child: const Text("Gluten-free",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff3B7D3C),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: SizedBox(
                  height: 40,
                  width: 187,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountDetails()));
                      },
                      child: const Text(
                        'Previous',
                        style:
                            TextStyle(color: Color(0xff3B7D3C), fontSize: 20),
                      ))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff3B7D3C),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff3B7D3C),
              ),
              child: SizedBox(
                  height: 40,
                  width: 187,
                  child: TextButton(
                    onPressed: ()  {
                      

                        // Navigate to the next page on successful sign up
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RootPage()),
                        );
                      
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

// Enrty field widget
Widget _entryField(String title, TextEditingController controller) {
  return Container(
    height: 47,
    width: 300,
    margin: const EdgeInsets.only(left: 1, right: 20),
    decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffD9D9D9), width: 2.0))),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: TextField(
        obscureText: (title == "Password") ? true : false,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: title,
            hintStyle: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.normal,
                color: Color(0xffBABABA))),
        style:
            const TextStyle(fontFamily: "Inter", fontWeight: FontWeight.normal),
      ),
    ),
  );
}
