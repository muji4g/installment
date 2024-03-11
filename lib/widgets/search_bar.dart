import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:installement1_app/theme/Colors.dart';
import 'package:installement1_app/theme/TextStyle.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  const AppSearchBar({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Center(
        child: TextFormField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12.0),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    'assets/images/magnifyingglass.svg',
                  ),
                ),
                iconColor: const Color(0xffC2C2C2),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: lowOpacityText)),
      ),
    );
  }
}
