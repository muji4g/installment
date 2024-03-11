import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

class AppBarSecondary extends StatelessWidget {
  final String title;

  final bool isarrowLeading;
  final bool showMenu;
  final VoidCallback onPressed;
  const AppBarSecondary(
      {super.key,
      required this.showMenu,
      required this.isarrowLeading,
      required this.onPressed,
      required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: bgColor,
      title: Text(
        title,
        style: customTextblack.copyWith(
            fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: isarrowLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onPressed,
            )
          : IconButton(
              icon: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.x,
                  size: 16,
                ),
                onPressed: onPressed,
              ),
              onPressed: onPressed,
            ),
      actions: showMenu
          ? [
              Image.asset('assets/images/menuIcon.png'),
            ]
          : null,
    );
  }
}
