import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onSignOut;
  final AuthBase auth;

  const HomePage({@required this.auth, @required this.onSignOut});

  Future<void> _signOut() async {
    try {
      auth.signOut();
      onSignOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная страница'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Выйти',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: _signOut,
          )
        ],
      ),
    );
  }
}
