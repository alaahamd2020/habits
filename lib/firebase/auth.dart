import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habits/model/user_model.dart';

class FBAuth {
  static final _auth = FirebaseAuth.instance;

  static UserModel? get user =>
      _auth.currentUser != null
          ? UserModel.fromFirebase(_auth.currentUser!)
          : null;

  static Stream<UserModel?> get userStream =>
      _auth.authStateChanges().map((User? user) =>
      user != null ? UserModel.fromFirebase(user) : null);

  static createUserWithEmailAndPassword(String email,
      String password, String name) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password,);
      credential.user!.sendEmailVerification();
      credential.user?.updateDisplayName(name);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Warning', 'This user already exists.',
            backgroundColor: Colors.deepOrange.shade100,
            icon: Icon(Icons.error, color: Colors.redAccent.shade700,));
      }
    }
  }


  static signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Get.snackbar('Warning', 'Wrong email or password.',
            backgroundColor: Colors.deepOrange.shade100,
            icon: Icon(Icons.error, color: Colors.redAccent.shade700,));
      }
    }
  }

  static signOut() {
    _auth.signOut();
  }
}