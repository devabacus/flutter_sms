import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/app/sign_in/email_signin_form.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';
import 'package:flutter_udemy_firebase/services/auth_provider.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация по почте'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(child: EmailSignForm()),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
