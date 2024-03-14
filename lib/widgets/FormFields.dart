import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/widgets/add_customer_widgets.dart';

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

class TextFieldBottomSheet extends StatelessWidget {
  final String hinttxt;
  const TextFieldBottomSheet({super.key, required this.hinttxt});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0.0),
          label: Text(
            hinttxt,
            style: customTextblack.copyWith(fontSize: size.width * 0.03),
          ),
          floatingLabelBehavior: null,
          labelStyle: customTextgrey.copyWith(fontSize: size.width * 0.03),
          hintStyle: customTextblack.copyWith(fontSize: 0.03)),
    );
  }
}
