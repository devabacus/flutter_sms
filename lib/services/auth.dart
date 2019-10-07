import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';




class User{
  final String uid;
  User({@required this.uid});
}

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> signInAnonimously();
  Future<void> signOut();

}

class Auth implements AuthBase{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user){
    if(user == null){
      return null;
    }
    return User(uid: user.uid);
  }

  Stream<User> get onAuthStateChanged{
     return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> currentUser() async {
    FirebaseUser user =  await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  Future<User> signInAnonimously() async {
    FirebaseUser user = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(user);
}

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }


}
