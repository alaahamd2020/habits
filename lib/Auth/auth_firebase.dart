/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habits/model/user_model.dart';

class AuthFirebase extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String? email, password;
  AuthFirebase({this.email, this.password});

  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  Rx<UserModel?> get user => _user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _user.bindStream(_auth.authStateChanges() as Stream<UserModel?>);
  }
   signInWithEmailAndPassword() async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      _user(UserModel( id: credential.user!.uid, name: 'name', email: 'email'));
    } on FirebaseAuthException catch (e){
      if (e.code == 'invalid-credential') {
        Get.snackbar('Warning', 'Wrong password or email.', backgroundColor: Colors.deepOrange.shade100, icon: Icon(Icons.error, color: Colors.redAccent.shade700,));
      }
    }
  }


}
*/
