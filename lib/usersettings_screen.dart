// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettings();
}

class _UserSettings extends State<UserSettings> {
  final TextEditingController nameController = TextEditingController();
  String userId = '';
  String userEmail = '';

  void fetchUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email ?? 'Email NOT Found';
        userId = user.uid;
      });
    }
  }

  @override
  void initState() {
    fetchUser();
    print(userEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBarSecondary(
            showMenu: false,
            isarrowLeading: true,
            onPressed: () {
              Navigator.pop(context);
            },
            title: 'User Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 12, left: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomGreyText(title: 'Personal Info'),
            Container(
              decoration: BoxDecoration(
                color: white,
              ),
              child: Column(
                children: [Text('Email'), Text('$userEmail')],
              ),
            )
          ],
        ),
      ),
    );
  }
}
