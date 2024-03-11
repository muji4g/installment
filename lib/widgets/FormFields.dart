import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  final TextEditingController formController;
  final String hinttxt;
  final bool obscuretext;
  final IconButton? visibilityIcon;
  const FormFields(
      {super.key,
      required this.formController,
      required this.obscuretext,
      required this.hinttxt,
      this.visibilityIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscuretext,
        controller: formController,
        decoration: InputDecoration(
          suffixIcon: visibilityIcon,
          hintText: hinttxt,
          contentPadding: EdgeInsets.all(14),
        ));
  }
}
