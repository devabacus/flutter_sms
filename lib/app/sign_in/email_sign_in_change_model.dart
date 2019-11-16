import 'package:flutter/cupertino.dart';
import 'package:flutter_udemy_firebase/app/sign_in/validators.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  EmailSignInChangeModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      @required this.auth,
      this.submitted = false});

  final AuthBase auth;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: true);
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passValidator.isValid(password) &&
        !isLoading;
  }

//  bool showErrorText = model.submitted && !widget.emailValidator.isValid(model.email);

  String get fieldErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidErrorText : null;
  }

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
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

  updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
