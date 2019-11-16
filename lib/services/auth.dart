import 'dart:async';
import 'dart:async' as prefix0;
import 'dart:core' as prefix1;
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;

  User({@required this.uid});
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;

  Future<User> currentUser();

  Future<User> signInAnonimously();

  Future<User> signInWithGoogle();

  Future<void> signOut();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> createUserWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  Future<User> signInAnonimously() async {
    FirebaseUser user = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(user);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(user);
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(user);
  }

  Future<User> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        FirebaseUser user = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));

        return _userFromFirebase(user);
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else {
      throw StateError('Google sign in aborted');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
