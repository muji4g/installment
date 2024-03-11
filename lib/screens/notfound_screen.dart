import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'NOT FOUND',
          style: customTextblack.copyWith(
              fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
