import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/app/home_page.dart';
import 'package:flutter_udemy_firebase/app/sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LangindPageState createState() => _LangindPageState();
}

class _LangindPageState extends State<LandingPage> {
  FirebaseUser _user;

  void _updateUser(FirebaseUser user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(onSignIn: _updateUser);
    }
    return HomePage();
  }
}
