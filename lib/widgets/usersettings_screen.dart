// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:installement1_app/screens/signup_page.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettings();
}

class _UserSettings extends State<UserSettings> {
  TextEditingController nameController = TextEditingController();
  String userEmail = '';
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController updatePasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isvisible = true;
  late String originalName;
  late String originalPassword;
  late String originalContact;
  late String originalAddress;
  late String oldPassword;

  //set original values////
  void initializeOriginalValues() {
    originalName = nameController.text;
    originalPassword = passwordController.text;
    oldPassword = passwordController.text;
    originalContact = contactController.text;
    originalAddress = addressController.text;
  }

  //Function To update the user Information
  void updateUserDetails() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'FullName': nameController.text,
        'password': passwordController.text,
        'ContactNum': contactController.text,
        'Adddress': addressController.text,
      });
    }
  }

  void fetchUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        userEmail = userData['Email'];

        nameController = TextEditingController(text: userData['FullName']);
        contactController = TextEditingController(text: userData['ContactNum']);
        passwordController = TextEditingController(text: userData['password']);
        oldPasswordController =
            TextEditingController(text: userData['password']);
        addressController = TextEditingController(text: userData['Adddress']);
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    initializeOriginalValues();
    fetchUser();
    print(userEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: PrimaryBtn(
            btntxt: 'Save',
            onPressedFunction: () {
              updateUserDetails();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  content: Text('Saved!')));
            },
            width: size.width * .12),
      ),
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBarSecondary(
            showLeading: true,
            showMenu: false,
            isarrowLeading: true,
            onPressed: () {
              Navigator.pop(context);
            },
            title: 'User Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: size.width * 0.011, left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomGreyText(title: 'Personal Info (Tap To Edit User Details)'),
            Container(
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.5, bottom: 9.0),
                        child: TextRowdetail(
                            InfoText: 'Email', detailText: '$userEmail'),
                      ),
                      EditAbleInfoRow(
                        obscureText: false,
                        controller: nameController,
                        text: 'Full Name',
                        onChanged: (value) {
                          originalName = value;
                        },
                      ),
                      EditAbleInfoRow(
                          onChanged: (value) {
                            originalContact = value;
                          },
                          obscureText: false,
                          controller: contactController,
                          text: 'Contact'),
                      EditAbleInfoRow(
                          onChanged: (value) {
                            originalAddress = value;
                          },
                          obscureText: false,
                          controller: addressController,
                          text: 'Address'),
                      EditAbleInfoRow(
                          onChanged: (value) {
                            originalPassword = value;
                          },
                          obscureText: true,
                          controller: passwordController,
                          text: 'Password'),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class TextRowdetail extends StatelessWidget {
  final String InfoText;
  final String detailText;
  const TextRowdetail(
      {super.key, required this.InfoText, required this.detailText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(InfoText), Text(detailText)],
    );
  }
}

// ignore: must_be_immutable
class EditAbleInfoRow extends StatelessWidget {
  final void Function(String)? onChanged;
  TextEditingController controller = TextEditingController();
  final String text;
  bool obscureText;
  EditAbleInfoRow(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.text,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        SizedBox(
          width: 160,
          child: TextFormField(
            onChanged: onChanged,
            obscureText: obscureText,
            decoration: InputDecoration(
                border: InputBorder.none, contentPadding: EdgeInsets.all(0.0)),
            style: customTextblack.copyWith(
              fontSize: 14,
            ),
            controller: controller,
          ),
        )
      ],
    );
  }
}
