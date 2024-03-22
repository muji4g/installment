import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';

class InstallmentPlan extends StatefulWidget {
  final String productId;
  // final Map<String, dynamic> productData;
  const InstallmentPlan({super.key, required this.productId});

  @override
  State<InstallmentPlan> createState() => _InstallmentPlanState();
}

class _InstallmentPlanState extends State<InstallmentPlan> {
  TextEditingController planNameController = TextEditingController();
  TextEditingController monthsController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();
  TextEditingController monthlyInsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBarSecondary(
            showLeading: false,
            showMenu: false,
            isarrowLeading: false,
            onPressed: () {},
            title: 'Installments Plan'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Column(
          children: [
            TextFormField(
              style: customTextblack.copyWith(fontSize: size.width * 0.03),
              controller: planNameController,
              decoration: InputDecoration(
                  hintText: 'Name of Installment Plan',
                  contentPadding: EdgeInsets.all(0)),
            ),
            TextFormField(
              style: customTextblack.copyWith(fontSize: size.width * 0.03),
              controller: planNameController,
              decoration: InputDecoration(
                  hintText: 'Months', contentPadding: EdgeInsets.all(0)),
            ),
            ReUseableTextForm(
              controller: monthlyInsController,
              hinttxt: 'DownPayment',
            ),
            ReUseableTextForm(
              controller: monthlyInsController,
              hinttxt: 'Monthly Installment',
            ),
          ],
        ),
      ),
    );
  }
}

class ReUseableTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hinttxt;
  const ReUseableTextForm(
      {super.key, required this.controller, required this.hinttxt});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextFormField(
      style: customTextblack.copyWith(fontSize: size.width * 0.03),
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(),
      decoration:
          InputDecoration(hintText: hinttxt, contentPadding: EdgeInsets.all(0)),
    );
  }
}
