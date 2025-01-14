import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:installement1_app/theme/app_colors.dart';

TextStyle customTextblue = GoogleFonts.poppins(color: primaryBlue, fontSize: 5);
TextStyle customTextwhite =
    GoogleFonts.poppins(color: Colors.white, fontSize: 12);
TextStyle customTextblack =
    GoogleFonts.poppins(color: Colors.black, fontSize: 12);
TextStyle customTextgrey = GoogleFonts.poppins(
  color: secondaryGrey,
);
TextStyle customTextsubtxt = GoogleFonts.poppins(
  color: secondaryBlue,
);
TextStyle lowOpacityText =
    GoogleFonts.poppins(color: Colors.black.withOpacity(0.3));
TextStyle customTextgreen = GoogleFonts.poppins(
  color: secondaryGreen,
);
TextStyle customTextred = GoogleFonts.poppins(
  color: secondaryRed,
);
TextStyle activebtntxt = GoogleFonts.poppins(color: Colors.white, fontSize: 12);
TextStyle offbtntxt = GoogleFonts.poppins(color: Colors.grey, fontSize: 12);

class CustomGreyText extends StatelessWidget {
  final String title;
  const CustomGreyText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.01),
      child: Text(
        title,
        style: customTextgrey.copyWith(fontSize: size.width * 0.03),
      ),
    );
  }
}
