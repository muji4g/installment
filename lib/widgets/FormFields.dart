import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/widgets/add_customer_widgets.dart';

class FormFields extends StatelessWidget {
  final TextEditingController formController;
  final String hinttxt;
  final bool obscuretext;
  final IconButton? visibilityIcon;
  final String validatorText;

  const FormFields(
      {super.key,
      required this.validatorText,
      required this.formController,
      required this.obscuretext,
      required this.hinttxt,
      this.visibilityIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return validatorText;
          }
        },
        obscureText: obscuretext,
        controller: formController,
        decoration: InputDecoration(
          suffixIcon: visibilityIcon,
          hintText: hinttxt,
          hintStyle: TextStyle(fontSize: 14),
        ));
  }
}

class TextFieldBottomSheet extends StatelessWidget {
  final TextEditingController resetPassController;
  final String hinttxt;
  const TextFieldBottomSheet(
      {super.key, required this.hinttxt, required this.resetPassController});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
      controller: resetPassController,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0.0),
          label: Text(
            hinttxt,
            style: customTextblack.copyWith(fontSize: size.width * 0.025),
          ),
          floatingLabelBehavior: null,
          labelStyle: customTextgrey.copyWith(fontSize: size.width * 0.025),
          hintStyle: customTextblack.copyWith(fontSize: 0.02)),
    );
  }
}
