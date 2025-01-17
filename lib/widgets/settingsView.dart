import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/screens/login_app.dart';
import 'package:installement1_app/screens/signup_page.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/widgets/usersettings_screen.dart';
import 'package:installement1_app/widgets/toggleButton.dart';

class SettingsView extends StatefulWidget {
  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool status = false;

  final List<Map<String, dynamic>> settingsOptions = [
    {
      'title': 'User',
      'subtitle': 'JohnWick',
      'icon': 'assets/images/settingUser.png',
      'hastoggle': false,
    },
    {
      'title': 'Get Updated',
      'subtitle': 'Notifications',
      'icon': 'assets/images/notifications.png',
      'hastoggle': true,
    },
    {
      'title': 'Language',
      'subtitle': 'English',
      'icon': 'assets/images/languageIcon.png',
      'hastoggle': false,
    },
    {
      'title': 'Terms & Conditions',
      'subtitle': 'Terms & Conditions',
      'icon': 'assets/images/terms.png',
      'hastoggle': false,
    },
    {
      'title': 'Logout',
      'subtitle': 'Logout Of Your Account',
      'icon': 'assets/images/logoutIcon.png',
      'hastoggle': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
        itemCount: settingsOptions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: GestureDetector(
              onTap: () {
                handleSettingsOptionTap(index);
              },
              child: ListTile(
                  title: Text(
                    settingsOptions[index]['title'],
                    style: customTextgrey.copyWith(
                      fontSize: size.width * 0.03,
                    ),
                  ),
                  leading: Image.asset(
                    settingsOptions[index]['icon'],
                    width: size.width * 0.07,
                  ),
                  subtitle: Text(
                    settingsOptions[index]['subtitle'],
                    style: customTextblack.copyWith(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    width: size.width * 0.11,
                    height: size.height * 0.03,
                    child: settingsOptions[index]['hastoggle']
                        ? const ToggleButton()
                        : null,
                  )),
            ),
          );
        },
      ),
    );
  }

  void handleSettingsOptionTap(int index) {
    Map option = settingsOptions[index];
    if (option['title'] == 'User') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const UserSettings()));
    } else if (option['title'] == 'Logout') {
      FirebaseAuth.instance.signOut().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginApp())));
      // controllerEmail.clear();
      // controllerPassword.clear();
    }
  }
}
