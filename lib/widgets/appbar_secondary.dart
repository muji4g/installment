import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/screens/edit_customer.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

class AppBarSecondary extends StatelessWidget {
  final String title;

  final bool isarrowLeading;
  final bool showMenu;
  final bool showLeading;
  final VoidCallback onPressed;
  const AppBarSecondary(
      {super.key,
      required this.showMenu,
      required this.isarrowLeading,
      required this.onPressed,
      required this.title,
      required this.showLeading});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: showLeading,
      elevation: 0.0,
      backgroundColor: bgColor,
      title: Text(
        title,
        style: customTextblack.copyWith(
            fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: showLeading
          ? isarrowLeading
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
                )
          : null,
      actions: showMenu
          ? [
              Padding(
                padding: EdgeInsets.only(right: size.width * 0.03),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        (MaterialPageRoute(
                            builder: (context) => const EditCustomerPage())));
                  },
                  child: Image.asset(
                    'assets/images/DotsThreeVertical.png',
                    width: size.width * 0.083,
                  ),
                ),
              ),
            ]
          : null,
    );
  }
}
