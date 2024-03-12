import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:installement1_app/model/userdetails_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';

class GreyText extends StatelessWidget {
  final String text;
  const GreyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Opacity(
      opacity: 0.4,
      child: Text(
        text,
        style: customTextblack.copyWith(
            fontSize: size.width * 0.034, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CustomerInfoCardUnpaid extends StatelessWidget {
  const CustomerInfoCardUnpaid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: size.hei,
          child: ListView.builder(
              itemCount: detailsList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {}),
        ),
      ),
    );
  }
}
