import 'package:flutter/material.dart';
import 'package:green_n_go/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_n_go/main.dart';
import 'package:green_n_go/screens/user_setup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailandPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          _controllerEmail.text, _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
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

  Widget _entryField(String title, TextEditingController controller) {
    return Container(
      height: 47,
      width: 900,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffBABABA), width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 9),
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
          style: const TextStyle(
              fontFamily: "Inter", fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm, $errorMessage');
  }

  // Widget _submitButton() {
  //   return ElevatedButton(
  //       onPressed: isLogin
  //           ? signInWithEmailandPassword
  //           : createUserWithEmailAndPassword,
  //       child: Text(isLogin ? 'Login' : 'Sign Up'));
  // }
  Widget _submitButton() {
    return Container(
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
              try {
                // Create user with email and password
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _controllerEmail.text,
                  password: _controllerPassword.text,
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RootPage()));
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
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }

  Widget _LoginOrRegisterButton() {
    return Container(
      child: Row(
        children: [
          Text('Don’t have an account?'),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserSetup()));
              },
              child: Text('Sign Up')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 90,
                    width: 90,
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  _entryField('Email', _controllerEmail),
                  _entryField('Password', _controllerPassword),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 13.0),
                        child: TextButton(
                            onPressed: null,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Color(0xff5AA5FF), fontSize: 12),
                            )),
                      )
                    ],
                  ),
                  _errorMessage(),
                  _submitButton(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 130.0),
                        child: _LoginOrRegisterButton(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
