import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:installement1_app/model/installments_model.dart';
import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

class BlueContainerRow extends StatelessWidget {
  const BlueContainerRow({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: primaryBlue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EMI',
              style: customTextblue.copyWith(fontSize: size.width * 0.04),
            ),
            Text('Monthly Installment',
                style: customTextblue.copyWith(fontSize: size.width * 0.04))
          ],
        ),
      ),
    );
  }
}

class InstallmentDetailRow extends StatelessWidget {
  final String value;
  final String label;
  final String text;
  const InstallmentDetailRow(
      {super.key,
      required this.label,
      required this.text,
      required this.value});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                value,
                style: customTextblack.copyWith(fontSize: size.width * 0.04),
              ),
              SizedBox(
                width: size.width * 0.007,
              ),
              Text(
                label,
                style: customTextblack.copyWith(fontSize: size.width * 0.04),
              ),
            ],
          ),
          Text(
            text,
            style: customTextblack.copyWith(fontSize: size.width * 0.04),
          )
        ],
      ),
    );
  }
}

class InstallmentPlanSection extends StatelessWidget {
  const InstallmentPlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.005, horizontal: size.width * 0.01),
        child: Column(
          children: [
            const BlueContainerRow(),
            InstallmentDetailRow(
                label: installments[1].installemtnPlanwords[0],
                value: installments[1].installmentPlan[0],
                text: installments[1].amount.toString()),
            InstallmentDetailRow(
                label: installments[1].installemtnPlanwords[0],
                value: installments[1].installmentPlan[1],
                text: installments[1].amount.toString()),
            InstallmentDetailRow(
                label: installments[1].installemtnPlanwords[0],
                value: installments[1].installmentPlan[2],
                text: installments[1].amount.toString()),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////
////////About Product Detail/////////////////
/////////////////////////////////////////////
class AboutProduct extends StatelessWidget {
  const AboutProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(17)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            productList[0].details,
            style: customTextblack.copyWith(fontSize: size.width * 0.034),
          ),
        ));
  }
}
