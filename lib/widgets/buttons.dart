import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/views/terms_conditions_view.dart';

class TextBtn extends StatelessWidget {
  final String btntxt;
  final dynamic fontsize;
  final VoidCallback onPressedFunction;
  const TextBtn(
      {super.key,
      required this.btntxt,
      required this.fontsize,
      required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
        onPressed: onPressedFunction,
        child: Text(
          textAlign: TextAlign.start,
          btntxt,
          style: customTextblue.copyWith(
              fontSize: size.width * fontsize, fontWeight: FontWeight.w500),
        ));
  }
}

//Primary Buttons

class PrimaryBtn extends StatelessWidget {
  final String btntxt;
  final double width;
  final VoidCallback onPressedFunction;
  final Color? backgroundColor;
  const PrimaryBtn(
      {super.key,
      required this.btntxt,
      required this.onPressedFunction,
      this.backgroundColor,
      required this.width});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Ink(
      width: width,
      height: size.height * .065,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: lineargradient,
      ),
      child: TextButton(
          onPressed: onPressedFunction,
          child: Text(
            btntxt,
            style: customTextwhite.copyWith(fontSize: size.width * 0.042),
          )),
    );
  }
}

//secondarybutton
class SecondayBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String btntxt;

  const SecondayBtn({super.key, required this.btntxt, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Ink(
      width: size.width * .9,
      height: size.height * .065,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: secondaryWhite,
      ),
      child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/google_icon.svg'),
              SizedBox(
                width: size.width * 0.03,
              ),
              Text(
                btntxt,
                style: customTextblack.copyWith(
                    fontSize: size.width * 0.042, fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}

//TermsAndConditions
class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Please read our',
          style: customTextblack.copyWith(fontSize: size.width * 0.036),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TermsConditions()));
          },
          child: Text(
            'Terms And Conditions',
            style: customTextblue.copyWith(
                fontSize: size.width * 0.036,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}

class customButton extends StatelessWidget {
  final String btnText;
  final Color btnColor;
  final Color btntxtcolor;
  final bool activeUser;
  final VoidCallback onpressedfunction;

  const customButton(
      {super.key,
      required this.btnText,
      required this.btnColor,
      required this.btntxtcolor,
      required this.activeUser,
      required this.onpressedfunction});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.width * 0.05),
      child: Ink(
        width: size.width * 0.245,
        decoration: BoxDecoration(
            color: btnColor, borderRadius: BorderRadius.circular(24)),
        child: TextButton(
          onPressed: onpressedfunction,
          child: Text(
            btnText,
            style: customTextwhite.copyWith(fontSize: 14, color: btntxtcolor),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String btnText;
  final Color btnColor;
  final Color textColor;
  final VoidCallback onpressedfunction;

  const CustomButton({
    Key? key,
    required this.btnText,
    required this.btnColor,
    required this.textColor,
    required this.onpressedfunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shadowColor: Colors.transparent,
            backgroundColor: btnColor),
        onPressed: onpressedfunction,
        child: Text(
          btnText,
          style: TextStyle(color: textColor),
        ));
  }
}

class BottomSheetButton extends StatefulWidget {
  final double width;
  final double height;
  final String btntxt;
  final VoidCallback onPressed;
  const BottomSheetButton(
      {super.key,
      required this.onPressed,
      required this.width,
      required this.btntxt,
      required this.height});

  @override
  State<BottomSheetButton> createState() => _BottomSheetButtonState();
}

class _BottomSheetButtonState extends State<BottomSheetButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onPressed,
      child: TextButton(
        onPressed: widget.onPressed,
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              gradient: lineargradient,
              borderRadius: BorderRadius.circular(24)),
          child: Text(
            widget.btntxt,
            style: customTextwhite.copyWith(fontSize: widget.width * 0.06),
          ),
        ),
      ),
    );
  }
}
