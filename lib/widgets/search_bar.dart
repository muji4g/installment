import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:installement1_app/theme/Colors.dart';
import 'package:installement1_app/theme/TextStyle.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  const AppSearchBar({
    super.key,
    required this.hintText,
  });

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

//search bar for products
class SearchBarProducts extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchBarProducts({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

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
          onChanged: onChanged,
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
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

/////S   E  A  R  C  H  B  A  R       C  A  T  E  G  O  R  I  E  S/////////
class SearchBarCategories extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchBarCategories({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

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
          onChanged: onChanged,
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
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
