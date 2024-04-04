// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:installement1_app/model/auth_model.dart';
import 'package:installement1_app/screens/signup_page.dart';
import 'package:installement1_app/screens/signup_screen_google.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/FormFields.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/large_strings.dart';

class LoginController extends StatefulWidget {
  const LoginController({Key? key}) : super(key: key);

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _resetPassController = TextEditingController();

  bool _isHidden = true;
  bool _isLoading = false;
  bool _isLoadingSignIn = false;
  bool _isLoadingGoogleSignIn = false;

  final LoginModel _model = LoginModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: SvgPicture.asset(
                'assets/images/logo_blue.svg',
                width: size.width * .30,
              )),
              SizedBox(
                height: size.height * .025,
              ),
              Text(
                'Sign In',
                style: customTextblack.copyWith(
                  fontSize: size.width * 0.052,
                  fontWeight:
                      FontWeight.lerp(FontWeight.w900, FontWeight.w900, 1),
                ),
              ),
              SizedBox(
                width: size.width * 0.65,
                child: Text(
                  'lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero ',
                  style: customTextblack.copyWith(
                      fontSize: size.width * 0.0235,
                      color: const Color(0xff9F9F9F)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: size.width * 0.9,
                child: FormFields(
                    validatorText: 'Enter Your Email',
                    obscuretext: false,
                    formController: _controllerEmail,
                    hinttxt: 'Email'),
              ),
              SizedBox(
                height: size.width * 0.06,
              ),
              SizedBox(height: 20.0),
              SizedBox(
                  width: size.width * 0.9,
                  child: FormFields(
                      validatorText: 'Enter Your Password',
                      obscuretext: _isHidden,
                      formController: _controllerPassword,
                      visibilityIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isHidden = !_isHidden;
                            });
                          },
                          icon: _isHidden
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )),
                      hinttxt: 'Password')),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(left: size.width * .53, top: 2),
                child: TextBtn(
                  btntxt: 'Reset Password?',
                  fontsize: 0.035,
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
                                        fontSize: size.width * 0.035,
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
                                    resetPassController: _resetPassController,
                                    hinttxt: 'EMAIL',
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  BottomSheetButton(
                                      btntxt: 'Reset',
                                      onPressed: () {
                                        print(_resetPassController.toString());
                                        _resetPassword();
                                        Navigator.pop(context);
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
              _isLoadingSignIn
                  ? Center(
                      child: SpinKitDualRing(
                        lineWidth: 2,
                        color: primaryBlue,
                        size: 40,
                      ),
                    )
                  : PrimaryBtn(
                      btntxt: 'Sign In',
                      onPressedFunction: () async {
                        var loginEmail = _controllerEmail.text.trim();
                        var loginPassword = _controllerPassword.text.trim();
                        if (loginEmail.isNotEmpty || loginPassword.isNotEmpty) {
                          _signInWithEmailAndPassword();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content: Text('Enter an Email OR Password'),
                          ));
                        }
                      },
                      width: size.width * 0.9,
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
              _isLoadingGoogleSignIn
                  ? Center(
                      child: SpinKitDualRing(
                        lineWidth: 2,
                        color: primaryBlue,
                        size: 40,
                      ),
                    )
                  : SecondayBtn(
                      onPressed: () {
                        _signInWithGoogle();
                      },
                      btntxt: 'Sign In With Google',
                    ),
              SizedBox(
                height: size.width * 0.04,
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithGoogle() async {
    setState(() {
      _isLoadingGoogleSignIn = true;
    });

    try {
      final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
      if (googleAccount == null) {
        // If no account selected, return
        setState(() {
          _isLoadingGoogleSignIn = false;
        });
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userSnapshot.exists) {
          // User exists, sign them in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => btmNavBar(
                      initialIndex: 0,
                    )),
          );
        } else {
          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          final AuthCredential emailAuthCredential =
              EmailAuthProvider.credential(
                  email: user.email.toString(), password: 'google password');
          await userCredential.user!.linkWithCredential(emailAuthCredential);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpGoogle(
                      email: user.email.toString(), // Pass Google email here
                    )),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text('Login Failed TRY Again error:'),
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _resetPassword() async {
    String email = _resetPassController.text.trim();
    if (email.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _model.resetPassword(email);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Row(
            children: [
              Icon(
                FontAwesomeIcons.check,
                size: 18,
                color: white,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                'Reset Email Sent Successfuly',
                style: TextStyle(color: white),
              )
            ],
          ),
        ));
        _resetPassController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
            content: Text('Failed to Send Email With ERROR $e ')));
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enter An Email')));
    }
  }

  void _signInWithEmailAndPassword() async {
    String email = _controllerEmail.text.trim();
    String password = _controllerPassword.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _isLoadingSignIn = true;
      });
      try {
        final User? user =
            await _model.signInWithEmailAndPassword(email, password);
        setState(() {
          _isLoadingSignIn = false;
        });
        if (user != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => btmNavBar(
                        initialIndex: 0,
                      )));
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: e.code == 'invalid-credential'
              ? Text('Invalid Email or Password')
              : e.code == 'invalid-email'
                  ? Text('Enter A  Valid Email')
                  : Text('Login Failed, Try Again Later'),
        ));

        setState(() {
          _isLoadingSignIn = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enter an Email and Password')));
      setState(() {
        _isLoadingSignIn = false;
      });
    }
  }
}
