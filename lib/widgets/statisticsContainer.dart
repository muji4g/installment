import 'package:flutter/cupertino.dart';

class StatisticsContainer extends StatelessWidget {
  final String totalNumber;
  final String secondaryText;
  final String type;
  final Color containerColor;

  final TextStyle style;
  final TextStyle secondarystyle;
  final TextStyle typestyle;

  const StatisticsContainer(
      {super.key,
      required this.totalNumber,
      required this.secondaryText,
      required this.containerColor,
      required this.style,
      required this.secondarystyle,
      required this.typestyle,
      required this.type});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.008),
      child: Container(
        width: size.width * .29,
        height: size.height * .17,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Color(0x29161617), // Use color value in RGBA format
            blurRadius: 20,
            spreadRadius: 0, // Adjust blur radius as needed
            offset: Offset(0, 4), // Adjust offset as needed
          )
        ], color: containerColor, borderRadius: BorderRadius.circular(22)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              totalNumber,
              style: style,
            ),
            SizedBox(
              height: size.width * 0.015,
            ),
            Text(
              secondaryText,
              style: secondarystyle,
            ),
            Text(
              type,
              style: typestyle,
            ),
          ],
        ),
      ),
    );
  }
}
