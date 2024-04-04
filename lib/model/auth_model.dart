import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:installement1_app/screens/signup_screen_google.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/snackbar.dart';

class LoginModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  // Future<User?> signingoogle(BuildContext context) async {
  //   // final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //   try {
  //     final GoogleSignInAccount? googleaccount = await GoogleSignIn().signIn();
  //     if (googleaccount == null) {
  //       return null;
  //     }
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleaccount.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     final User? user = userCredential.user;

  //     if (user != null) {
  //       final DocumentSnapshot emailDocument = await _users.doc(user.uid).get();
  //       final DocumentSnapshot email = await _users.doc(user.email).get();
  //       if (emailDocument.exists) {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => btmNavBar()));
  //       } else {
  //         await _users.doc(user.uid).set({'email': user.email});
  //         final AuthCredential emailAuthCredential =
  //             EmailAuthProvider.credential(
  //                 email: user.email.toString(), password: 'google password');
  //         await userCredential.user!.linkWithCredential(emailAuthCredential);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => SignUpGoogle(email: email.toString())));
  //       }
  //     }
  //     GoogleSignIn().signOut();
  //     return user;
  //   } catch (e) {
  //     print('$e');
  //   }
  //   return null;
  // }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error resetting password: $e');
      throw e;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('Error signing in with email and password: $e');
      throw e;
    }
  }
}
