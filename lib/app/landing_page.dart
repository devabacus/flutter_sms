import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/app/home_page.dart';
import 'package:flutter_udemy_firebase/app/sign_in/sign_in_page.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});

  final AuthBase auth;

  @override
  _LangindPageState createState() => _LangindPageState();
}

class _LangindPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(auth: widget.auth, onSignIn: _updateUser);
    }
    return HomePage(auth: widget.auth, onSignOut: () => _updateUser(null));
  }
}
