import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';

class SignInManager {
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;
  SignInManager({@required this.auth, @required this.isLoading});

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<User> signInAnonimously() async =>
      await _signIn(auth.signInAnonimously);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
}
