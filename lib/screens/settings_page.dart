import 'package:flutter/material.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/widgets/appbar.dart';
import 'package:installement1_app/widgets/settingsView.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: Padding(
              padding:
                  EdgeInsets.only(top: size.width * 0.011, left: 12, right: 12),
              child: appBar(
                onPressedFunction: () {},
                title: 'Settings',
                addIcon: false,
              ),
            )),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/settingsProfile.png'),
                  SizedBox(
                    height: size.width * 0.025,
                  ),
                  Text(
                    'John Wick',
                    style: customTextblue.copyWith(fontSize: size.width * 0.04),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.13,
            ),
            SettingsView(),
          ],
        ),
      ),
    );
  }
}
