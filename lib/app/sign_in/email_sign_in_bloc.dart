import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_udemy_firebase/app/sign_in/email_sign_in_model.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';

class EmailSignInBloc {
  final AuthBase auth;

  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  EmailSignInBloc({@required this.auth});

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: true);
    }
  }

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(email: password);

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    //update model
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isLoading: isLoading,
        submitted: submitted);

    _modelController.add(_model);
  }
}
