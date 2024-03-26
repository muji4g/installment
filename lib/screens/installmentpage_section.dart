// ignore_for_file: prefer_const_declarations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/userUnpaid_info_cards.dart';

class InstallmentPlan extends StatefulWidget {
  final String productId;
  // final Map<String, dynamic> productData;
  const InstallmentPlan({
    super.key,
    required this.productId,
  });

  @override
  State<InstallmentPlan> createState() => _InstallmentPlanState();
}

class _InstallmentPlanState extends State<InstallmentPlan> {
  TextEditingController planNameController = TextEditingController();
  TextEditingController monthsController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();
  TextEditingController monthlyInsController = TextEditingController();
  double total = 0;
  void _calculateTotal() {
    // Parse the numerical values from the controllers
    double months = double.tryParse(monthlyInsController.text) ?? 0;
    double downPayment = double.tryParse(downPaymentController.text) ?? 0;

    // Calculate the total
    setState(() {
      total = months + downPayment;
      total;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calculateTotal();
  }

  ///Function to ADD installment
  void _addInstallment() {
    //Info to be added
    String planName = planNameController.text;
    String months = monthsController.text;
    String downPayment = downPaymentController.text;
    String monthlyInstallment = monthlyInsController.text;

    // Access the current user
    User? user = FirebaseAuth.instance.currentUser;

    CollectionReference productsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('products');

    DocumentReference installmentPlanDocRef = productsCollection
        .doc(widget.productId)
        .collection('installmentPlan')
        .doc();
    // Add the installment plan to the documnet

    installmentPlanDocRef.set({
      'planName': planName,
      'months': months,
      'downPayment': downPayment,
      'monthlyInstallment': monthlyInstallment,
    }).then((value) {
      final snackBar = const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('PLAN ADDED Succesfuly'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      // Failed to add installment plan
      final snackBar = const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Failed'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    print('Fucntion called');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
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
              decoration: const InputDecoration(
                  hintText: 'Name of Installment Plan',
                  contentPadding: EdgeInsets.all(0)),
            ),
            TextFormField(
              style: customTextblack.copyWith(fontSize: size.width * 0.03),
              controller: monthsController,
              decoration: const InputDecoration(
                  hintText: 'Months', contentPadding: EdgeInsets.all(0)),
            ),
            ReUseableTextForm(
              controller: downPaymentController,
              hinttxt: 'DownPayment',
            ),
            ReUseableTextForm(
              controller: monthlyInsController,
              hinttxt: 'Monthly Installment',
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [GreyText(text: 'TOTAL'), Text(total.toString())],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PrimaryBtn(
                  btntxt: 'Add Installment',
                  onPressedFunction: () {
                    _addInstallment();
                  },
                  width: size.width * 0.8),
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
      decoration: InputDecoration(
          hintText: hinttxt, contentPadding: const EdgeInsets.all(0)),
    );
  }
}
