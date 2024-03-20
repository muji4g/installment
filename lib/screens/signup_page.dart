import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:installement1_app/model/userdetails_model.dart';
import 'package:installement1_app/screens/login_app.dart';
import 'package:installement1_app/services/signUp_services.dart';
import 'package:installement1_app/theme/Textstyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/FormFields.dart';

import '../widgets/buttons.dart';

class SignUpApp extends StatefulWidget {
  const SignUpApp({super.key});

  @override
  State<SignUpApp> createState() => _SignUpAppState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _SignUpAppState extends State<SignUpApp> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController createPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final auth = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            'Register',
            style: customTextblack.copyWith(
                fontSize: size.width * .06, fontWeight: FontWeight.w900),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 7.0),
              child: TextBtn(
                onPressedFunction: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginApp()),
                      (route) => false);
                },
                btntxt: 'Sing In',
                fontsize: 0.035,
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /////Form to validate signup fields, if they are empty or not!
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        FormFields(
                            validatorText: 'Enter Name',
                            formController: fullnameController,
                            obscuretext: false,
                            hinttxt: 'Full Name'),
                        FormFields(
                            validatorText: 'Enter Email',
                            formController: emailController,
                            obscuretext: false,
                            hinttxt: 'Email'),
                        FormFields(
                            validatorText: 'Enter Contact',
                            formController: contactController,
                            obscuretext: false,
                            hinttxt: 'Contact'),
                        FormFields(
                            validatorText: 'Enter A Store Name',
                            formController: storeNameController,
                            obscuretext: false,
                            hinttxt: 'Store Name'),
                        FormFields(
                            validatorText: 'Enter Your Shop Address',
                            formController: addressController,
                            obscuretext: false,
                            hinttxt: 'Address'),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        FormFields(
                            validatorText:
                                'Enter Your Password atleast 8 digits',
                            formController: passwordController,
                            obscuretext: true,
                            hinttxt: 'Create Password'),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            'password as unique as you are your gateway to secure and seamless access.',
                            style: customTextgrey.copyWith(
                                fontSize: size.width * 0.025),
                          ),
                        ),
                        FormFields(
                            validatorText: 'Kindly Confirm Your Password',
                            formController: confirmPassController,
                            obscuretext: true,
                            hinttxt: 'Confirm Password'),
                      ],
                    )),

                SizedBox(
                  height: size.height * .03,
                ),
                PrimaryBtn(
                  width: size.width * 0.9,
                  btntxt: 'Sign Up',
                  onPressedFunction: () async {
                    var userName = fullnameController.text.trim();
                    var userEmail = emailController.text.trim();
                    var userContact = contactController.text.trim();
                    var storeName = storeNameController.text.trim();
                    var userAddress = addressController.text.trim();
                    var userPassword = passwordController.text.trim();
                    var confirmPassword = confirmPassController.text.trim();
                    if (formKey.currentState!.validate()) {
                      if (userPassword.length < 8) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text(
                              'Password Must be atleast 8 digits or Longer'),
                        ));
                      } else if (userPassword != confirmPassword) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text('Passwords Do Not Match'),
                        ));
                      } else {
                        await auth
                            .createUserWithEmailAndPassword(
                                email: userEmail, password: userPassword)
                            .then(
                              (value) => {
                                signUpuser(userName, userEmail, userContact,
                                    storeName, userAddress, userPassword),
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green,
                                  content: Text('User Created Successfully!'),
                                )),
                                FirebaseAuth.instance.signOut(),
                                passwordController.clear(),
                                fullnameController.clear(),
                                contactController.clear(),
                                storeNameController.clear(),
                                addressController.clear(),
                                createPassController.clear(),
                                confirmPassController.clear(),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginApp()))
                              },
                            );
                      }
                    }
                  },
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Text(
                  'or',
                  style: customTextgrey.copyWith(fontSize: size.width * 0.03),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                SecondayBtn(
                  onPressed: () {},
                  btntxt: 'Sign Up With Google',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// String email, String password
