import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habits/model/user_model.dart';
import 'package:habits/generated/l10n.dart';

class FBAuth {
  static final _auth = FirebaseAuth.instance;

  static UserModel? get user => _auth.currentUser != null
      ? UserModel.fromFirebase(_auth.currentUser!)
      : null;

  static Stream<UserModel?> get userStream => _auth.userChanges().map(
    (User? user) => user != null ? UserModel.fromFirebase(user) : null,
  );

  static createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      credential.user?.updateDisplayName(name);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Warning',
          'This user already exists.',
          backgroundColor: Colors.deepOrange.shade100,
          icon: Icon(Icons.error, color: Colors.redAccent.shade700),
        );
      }
    }
  }

  static signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            Get.snackbar(
              'تم تسجيل الدخول بنجاح',
              'أهلاً بك مرة أخرى',
              backgroundColor: Colors.green.shade100,
              icon: Icon(Icons.done, color: Colors.green.shade700),
            );
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Get.snackbar(
          'Warning',
          'Wrong email or password.',
          backgroundColor: Colors.deepOrange.shade100,
          icon: Icon(Icons.error, color: Colors.redAccent.shade700),
        );
      }
    }
  }

  static signOut() {
    _auth.signOut();
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String message = S.current.error_occurred;
      if (e.code == 'user-not-found') {
        message = "User not found with this email.";
      } else if (e.code == 'too-many-requests') {
        message = "Too many requests. Try again later.";
      } else {
        message = e.message ?? message;
      }
      Get.snackbar(
        'Warning',
        message,
        backgroundColor: Colors.deepOrange.shade100,
        icon: Icon(Icons.error, color: Colors.redAccent.shade700),
      );
      throw e;
    } catch (e) {
      Get.snackbar(
        'Warning',
        'Failed to send password reset email.',
        backgroundColor: Colors.deepOrange.shade100,
        icon: Icon(Icons.error, color: Colors.redAccent.shade700),
      );
      throw e;
    }
  }

  static Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
    } catch (e) {
      Get.snackbar(
        'Warning',
        'Failed to update password. You may need to sign in again.',
        backgroundColor: Colors.deepOrange.shade100,
        icon: Icon(Icons.error, color: Colors.redAccent.shade700),
      );
      throw e;
    }
  }

  static Future<void> updateDisplayName(String newName) async {
    try {
      await _auth.currentUser?.updateDisplayName(newName);
      await _auth.currentUser?.reload(); // Refresh the user object
    } catch (e) {
      Get.snackbar(
        'Warning',
        'Failed to update name.',
        backgroundColor: Colors.deepOrange.shade100,
        icon: Icon(Icons.error, color: Colors.redAccent.shade700),
      );
      throw e;
    }
  }
}
