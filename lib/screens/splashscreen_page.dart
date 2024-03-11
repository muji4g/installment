import 'package:flutter/material.dart';
import 'package:installement1_app/screens/dashboard_page.dart';
import 'package:installement1_app/screens/login_app.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: lineargradient,
          ),
          child: Center(
            child: SvgPicture.asset('assets/images/ins_logo.svg',
                width: size.width * .19, height: size.height * .19),
          )),
    );
  }
}
