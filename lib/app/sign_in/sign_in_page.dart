import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/app/sign_in/sign_in_button.dart';
import 'package:flutter_udemy_firebase/app/sign_in/social_signin_button.dart';
import 'package:flutter_udemy_firebase/common_widgets/custom_raised_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatelessWidget {

  Future<void> _signInAnonymously() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.signInAnonymously();
      print('${user.uid}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Учет времени'),
        elevation: 2,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 30,
          ),
          SocialSignInButton(
            color: Colors.white,
            onPressed: () {},
            imageAsset: 'images/google-logo.png',
            text: 'Войти через Google',
            textColor: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          SocialSignInButton(
            color: Color(0xFF334D92),
            onPressed: () {},
            imageAsset: 'images/facebook-logo.png',
            text: 'Войти через Facebook',
            textColor: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            text: 'Войти через Email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'or',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SignInButton(
            text: 'Гостевой режим',
            textColor: Colors.white,
            color: Colors.deepOrange,
            onPressed: _signInAnonymously,
          ),
        ],
      ),
    );
  }

  void _signInWithGoogle() {}
}
