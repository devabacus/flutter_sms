import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/app/sign_in/sign_in_button.dart';
import 'package:flutter_udemy_firebase/common_widgets/custom_raised_button.dart';

class SignInPage extends StatelessWidget {
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
            height: 10,
          ),
          SignInButton(
            text: 'SignIn with Google',
            textColor: Colors.black,
            color: Colors.white,
            onPressed: (){},
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _signInWithGoogle() {

  }

}
