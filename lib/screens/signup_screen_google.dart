import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:installement1_app/screens/login_app.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/widgets/FormFields.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/buttons.dart';

class SignUpGoogle extends StatefulWidget {
  final String? email;
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
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<String?> getUserDisplayName(User user) async {
    try {
      await user.reload();
      final User? currentUser = FirebaseAuth.instance.currentUser;

      return currentUser!.displayName;
    } catch (error) {
      print('Error retrieving user display name: $error');
      return null;
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
        'Full Name': getUserDisplayName(FirebaseAuth.instance.currentUser!)
      });
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 18),
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
                      FormFields(
                        validatorText: 'Enter A Store Name',
                        formController: storeNameController,
                        obscuretext: false,
                        hinttxt: 'Store Name',
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
                SecondayBtn(
                  onPressed: () async {
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
                            accessToken: googleSignInAuthentication.accessToken,
                            idToken: googleSignInAuthentication.idToken,
                          );
                          final UserCredential userCredential =
                              await auth.signInWithCredential(credential);
                          final User? user = userCredential.user;

                          if (user != null) {
                            // Save additional user data to Firestore
                            await saveUserData(user.uid, user.email!,
                                userContact, storeName, userAddress);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => btmNavBar()),
                            );
                          }
                        }
                      } catch (e) {}
                    }
                  },
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
