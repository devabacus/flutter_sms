import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/app/sign_in/validators.dart';
import 'package:flutter_udemy_firebase/common_widgets/form_submit_button.dart';
import 'package:flutter_udemy_firebase/common_widgets/platform_alert_dialog.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';
import 'package:flutter_udemy_firebase/services/auth_provider.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignForm extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _EmailSignFormState createState() => _EmailSignFormState();
}

class _EmailSignFormState extends State<EmailSignForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  String get _email => _emailController.text;

  String get _pass => _passController.text;
  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {
    print('submit called');
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = AuthProvider.of(context);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _pass);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _pass);
      }
      Navigator.of(context).pop();
    } catch (e) {
      PlatformAlertDialog(
        title: "Ошибка авторизации чувак",
        content: e.toString(),
        defaultActionText: 'OK',
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Войти'
        : 'Зарегистрироваться';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Нет аккаунта? Зарегистрируйся'
        : 'Есть аккаунт? Войдите';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passValidator.isValid(_pass) &&
        !_isLoading;
    setState(() {});

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8,
      ),
      _buildPassTextField(),
      SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(
        height: 8,
      ),
      FlatButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      )
    ];
  }

  TextField _buildPassTextField() {
    bool showErrorText = _submitted && !widget.passValidator.isValid(_pass);

    return TextField(
      controller: _passController,
      textInputAction: TextInputAction.done,
      focusNode: _passFocusNode,
      onEditingComplete: _submit,
      decoration: InputDecoration(
          labelText: 'Пароль',
          enabled: _isLoading ? false : true,
          errorText: showErrorText ? widget.invalidErrorText : null),
//           errorText: widget.invalidErrorText,

      obscureText: true,
      onChanged: (pass) => _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      onEditingComplete: _emailEditingComplete,
      decoration: InputDecoration(
        labelText: 'Почта',
        hintText: 'test@test.ru',
        enabled: _isLoading ? false : true,
        errorText: showErrorText ? widget.invalidErrorText : null,
//        errorText: widget.invalidErrorText,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: _buildChildren()),
    );
  }

  void _updateState() {
    setState(() {});
  }
}
