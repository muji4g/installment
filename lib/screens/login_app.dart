// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, prefer_const_constructors

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:installement1_app/screens/dashboard_page.dart';

import 'package:installement1_app/screens/signup_page.dart';
import 'package:installement1_app/screens/signup_screen_google.dart';
import 'package:installement1_app/theme/TextStyle.dart';

import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/FormFields.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/large_strings.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  ScrollController scrollController = ScrollController();
  bool isHidden = true;
  bool isLoading = false;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController resetPassController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

/////////////////////////////////////////////////////////////
  //////////Function for Google SIGN IN/////////////////////
  ///////////////////////////////////////////////////

  Future<User?> signingoogle() async {
    try {
      final GoogleSignInAccount? googleaccount = await GoogleSignIn().signIn();
      print('creating a google user sign in session');

      if (googleaccount == null) {
        print('if null functionality');
        return null;
      }
      print('Creating Google Auth');
      final GoogleSignInAuthentication googleAuth =
          await googleaccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('creating User Credential');

      final User? user = userCredential.user;

      if (user != null) {
        final CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        print('Null check');
        final DocumentSnapshot emailDocument = await users.doc(user.uid).get();
        final DocumentSnapshot email = await users.doc(user.email).get();
        if (emailDocument.exists) {
          print('Push To btmnavbar screen');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => btmNavBar()));
          //   break;
          print('Push To btmnavbar screen');
        } else {
          await users.doc(user.uid).set({'email': user.email});
          final AuthCredential emailAuthCredential =
              EmailAuthProvider.credential(
                  email: user.email.toString(), password: 'google password');
          await userCredential.user!.linkWithCredential(emailAuthCredential);
          print('Push To SIGNUP SCREEN');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpGoogle(
                        email: email.toString(),
                      )));
          print('Push hhh To SIGNUP SCREEN');
        }
      } else {}
      GoogleSignIn().signOut();
      return user;
    } catch (e) {
      print('$e');
    }
    return null;
  }

  // Future<bool> checkUserExists(String uid) async {
  //   try {
  //     // Retrieve user data from Firebase Authentication
  //     User? user = FirebaseAuth.instance.currentUser;

  //     // Check if the user is not null and their UID matches the provided UID
  //     if (user != null && user.uid == uid) {
  //       return true; // User exists
  //     } else {
  //       return false; // User does not exist
  //     }
  //   } catch (e) {
  //     print('Error checking user existence: $e');
  //     return false; // Assume user does not exist in case of an error
  //   }
  // }
  Future<bool> checkUserExists(String uid) async {
    try {
      User? firebaseUser = auth.currentUser;
      return firebaseUser != null;
    } catch (e) {
      print('Error checking user existence: $e');
      return false;
    }
  }

  //////////////////////PasswordResetfUNCTION///////////////////
  void resetPassword() async {
    String email = resetPassController.text.trim();
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
            (value) => SnackBar(content: Text('Reset Email Has Been Sent')));
      } catch (e) {
        final snackBar = SnackBar(
          content: Text('$e'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(
        content: Text('Enter An Email'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

////////////////////////////////////////////////
///////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    print('rebuilt');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: TextBtn(
              onPressedFunction: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpApp()),
                    (route) => false);
              },
              btntxt:
                  'Sing Up', //this buttons state might need to be changed with provider
              fontsize: 0.035,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TermsAndConditions(),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SvgPicture.asset(
                'assets/images/logo_blue.svg',
                width: size.width * .30,
              )),
              SizedBox(
                height: size.height * .025,
              ),
              Center(
                child: Text(
                  'Sign In',
                  style: customTextblack.copyWith(
                    fontSize: size.width * 0.052,
                    fontWeight:
                        FontWeight.lerp(FontWeight.w900, FontWeight.w900, 1),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: size.width * 0.65,
                  child: Text(
                    'lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero ',
                    style: customTextblack.copyWith(
                        fontSize: size.width * 0.0235,
                        color: const Color(0xff9F9F9F)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .030,
              ),
              SizedBox(
                  width: size.width * 0.9,
                  child: FormFields(
                      validatorText: 'Enter Your Email',
                      obscuretext: false,
                      formController: controllerEmail,
                      hinttxt: 'Email')),
              SizedBox(
                height: size.width * 0.06,
              ),
              SizedBox(
                  width: size.width * 0.9,
                  child: FormFields(
                      validatorText: 'Enter Your Password',
                      obscuretext: isHidden,
                      formController: controllerPassword,
                      visibilityIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: isHidden
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )),
                      hinttxt: 'Password')),
              Padding(
                padding: EdgeInsets.only(left: size.width * .55, top: 2),
                child: TextBtn(
                  btntxt: 'Reset Password?',
                  fontsize: 0.040,
                  onPressedFunction: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      barrierColor: primaryBlue.withOpacity(0.3),
                      builder: (context) => BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.03,
                                horizontal: size.width * 0.1),
                            child: SingleChildScrollView(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Reset Password',
                                    style: customTextblack.copyWith(
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Text(
                                    resetstr,
                                    style: customTextblack.copyWith(
                                        fontSize: size.width * 0.022,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.015,
                                  ),
                                  TextFieldBottomSheet(
                                    resetPassController: resetPassController,
                                    hinttxt: 'EMAIL',
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  BottomSheetButton(
                                      btntxt: 'Reset',
                                      onPressed: () {
                                        print(resetPassController.toString());
                                        resetPassword();
                                      },
                                      width: size.width * 0.7,
                                      height: size.height * 0.05)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              PrimaryBtn(
                btntxt: 'SignIn',
                width: size.width * 0.9,
                onPressedFunction: () async {
                  var loginEmail = controllerEmail.text.trim();
                  var loginPassword = controllerPassword.text.trim();
                  if (loginPassword.isNotEmpty && loginEmail.isNotEmpty) {
                    try {
                      final User? firebaseUser = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: loginEmail, password: loginPassword))
                          .user;
                      if (firebaseUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const btmNavBar()));
                        emailController.clear();
                        passwordController.clear();
                      }
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: e.code == 'invalid-email'
                              ? Text('Enter A Valid Email!')
                              : e.code == 'invalid-credential'
                                  ? Text(
                                      'The Email or Password are not correct')
                                  : Text('Unknown Error Try Again Later!')));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      content: Text('Enter an Email OR Password'),
                    ));
                  }
                },
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Text(
                'or',
                style: customTextgrey.copyWith(fontSize: size.width * 0.03),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              SecondayBtn(
                onPressed: () {
                  signingoogle();
                },
                btntxt: 'Sign In With Google',
              ),
              SizedBox(
                height: size.width * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // controllerEmail.dispose();
    // controllerPassword.dispose();

    scrollController.dispose();
    super.dispose();
  }
}


  // Future<void> signInWithGoogle() async {
  //   try {
  //     GoogleSignIn().signOut();
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );

  //       final UserCredential userCredential =
  //           await auth.signInWithCredential(credential);
  //       final User? user = userCredential.user;

  //       if (user != null) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => SignUpGoogle()),
  //         );
  //       } else {
  //         // Handle the case where user is null
  //         print('Error signing in with Google: User is null');
  //       }
  //     }
  //   } catch (e) {
  //     // Handle the Google Sign-In error
  //     print('Error signing in with Google: $e');
  //   }
  // }