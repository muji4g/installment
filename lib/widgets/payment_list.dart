import 'package:flutter/material.dart';
import 'package:installement1_app/model/payments_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/buttons.dart';

class PaymentType extends StatefulWidget {
  PaymentType({
    super.key,
  });

  @override
  State<PaymentType> createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.05,
      child: ListView.builder(
          itemCount: paymentslist.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.009),
              child: CustomButton(
                  btnText: paymentslist[index].paymenttype,
                  btnColor: paymentslist[index].isSelected
                      ? primaryBlue
                      : Colors.white,
                  textColor: paymentslist[index].isSelected
                      ? Colors.white
                      : Colors.grey,
                  onpressedfunction: () {}),
            );
          }),
    );
  }
}
