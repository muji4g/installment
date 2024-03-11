import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => ToggleButtonState();
}

class ToggleButtonState extends State<ToggleButton> {
  bool state = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlutterSwitch(
        toggleSize: size.width * 0.05,
        width: size.width * 0.14,
        height: size.height * 0.03,
        padding: 1.0,
        value: state,
        onToggle: (value) {
          setState(() {
            state = !state;
          });
        });
  }
}
