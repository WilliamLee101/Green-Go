import 'package:flutter/material.dart';
import 'package:green_n_go/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    bool isPass = false;
    if (title == "Password") {
      isPass = true;
    }
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
            obscureText: isPass),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm, $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailandPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Sign Up'));
  }

  Widget _LoginOrRegisterButton() {
    return Container(
      child: Row(
        children: [
          Text(isLogin ? 'Don’t have an account?' : 'Already have an account?'),
          TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(isLogin ? 'Sign Up' : 'Login')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Image.asset("assets/images/logo.png", height: 120, width: 120,),
                  Text(
                    isLogin ? '' : 'Create an account!',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
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
