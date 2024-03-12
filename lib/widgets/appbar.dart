import 'package:flutter/material.dart';

import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

class appBar extends StatefulWidget {
  final String title;
  final bool addIcon;
  final VoidCallback onPressedFunction;

  const appBar(
      {super.key,
      required this.title,
      required this.addIcon,
      required this.onPressedFunction});

  @override
  State<appBar> createState() => _appBarState();
}

class _appBarState extends State<appBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: bgColor,
      title: Text(
        widget.title,
        style:
            customTextblack.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      centerTitle: false,
      actions: [
        Container(
          height: size.height * 0.04,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: primaryBlue),
          child: Center(
              child: widget.addIcon
                  ? IconButton(
                      onPressed: widget.onPressedFunction,
                      icon: Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: size.width * 0.05,
                      ))
                  : null),
        ),
      ],
    );
  }
}
