import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:installement1_app/screens/login_app.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/FormFields.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/buttons.dart';

class SignUpGoogle extends StatefulWidget {
  final String email;
  const SignUpGoogle({Key? key, required this.email}) : super(key: key);

  @override
  State<SignUpGoogle> createState() => _SignUpGoogleState();
}

class _SignUpGoogleState extends State<SignUpGoogle> {
  TextEditingController contactController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                onPressedFunction: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginApp()),
                  );
                  await FirebaseAuth.instance.currentUser!.delete();
                },
                btntxt: 'Sign In',
                fontsize: 0.035,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        FormFields(
                          validatorText: 'Contact Number',
                          formController: contactController,
                          obscuretext: false,
                          hinttxt: 'Contact Number',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormFields(
                          validatorText: 'Enter A Store Name',
                          formController: storeNameController,
                          obscuretext: false,
                          hinttxt: 'Store Name',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormFields(
                          validatorText: 'Enter Your Shop Address',
                          formController: addressController,
                          obscuretext: false,
                          hinttxt: 'Address',
                        ),
                        SizedBox(height: size.height * .01),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * .03),
                  isLoading
                      ? const Center(
                          child: SpinKitDualRing(
                          lineWidth: 2,
                          color: primaryBlue,
                          size: 40,
                        ))
                      : SecondayBtn(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            var userContact = contactController.text.trim();
                            var storeName = storeNameController.text.trim();
                            var userAddress = addressController.text.trim();
                            if (formKey.currentState!.validate()) {
                              try {
                                final GoogleSignInAccount? googleSignInAccount =
                                    await _googleSignIn.signIn();
                                if (googleSignInAccount != null) {
                                  final GoogleSignInAuthentication
                                      googleSignInAuthentication =
                                      await googleSignInAccount.authentication;
                                  final AuthCredential credential =
                                      GoogleAuthProvider.credential(
                                    accessToken:
                                        googleSignInAuthentication.accessToken,
                                    idToken: googleSignInAuthentication.idToken,
                                  );
                                  final UserCredential userCredential =
                                      await auth
                                          .signInWithCredential(credential);
                                  final User? user = userCredential.user;

                                  if (user != null) {
                                    // Save additional user data to Firestore
                                    await saveUserData(user.uid, widget.email,
                                        userContact, storeName, userAddress);
                                    if (await userExists(user.uid)) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginApp()),
                                      );
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => btmNavBar(
                                                    initialIndex: 0,
                                                  )));
                                    }
                                  }
                                }
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          btntxt: 'Sign Up With Google',
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> userExists(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(userId).get();
      return userDoc.exists;
    } catch (e) {
      print('Error checking if user exists: $e');
      return false;
    }
  }

  Future<void> saveUserData(String userId, String email, String contact,
      String storeName, String address) async {
    try {
      // Save user data to Firestore
      await firestore.collection('users').doc(userId).set({
        'Email': email,
        'ContactNum': contact,
        'storeName': storeName,
        'Adddress': address,
      });
    } catch (e) {
      print('Error saving user data: $e');
    }
  }
}
