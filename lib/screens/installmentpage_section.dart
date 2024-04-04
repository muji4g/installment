// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installement1_app/screens/add_product.dart';
import 'package:installement1_app/screens/products_page.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/add_installment_components.dart';
import 'package:installement1_app/widgets/addinstallment_bottomsheet.dart';
import 'package:installement1_app/widgets/appbar.dart';
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
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  double total = 0;
  final _formKey = GlobalKey<FormState>(); // Add form key
  void _calculateTotal() {
    double downPayment = double.tryParse(downPaymentController.text) ?? 0;
    double monthlyInstallment = double.tryParse(monthlyInsController.text) ?? 0;
    setState(() {
      total = downPayment + monthlyInstallment;
    });
  }

  bool hasInstallments = false;
  void toggleInstallments(bool hasInstallments) {
    setState(() {
      this.hasInstallments = hasInstallments;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _showAddInstallmentBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      barrierColor: primaryBlue.withOpacity(0.3),
      builder: (context) {
        return AddInstallmentBottomSheet(
          planController: planNameController,
          monthsController: monthsController,
          downPaymentController: downPaymentController,
          monthlyInstallmentController: monthlyInsController,
          productId: widget.productId,
        );
      },
    );
  }

  ///Function to ADD installment
  void _addInstallment() {
    setState(() {
      isLoading = true;
    });
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
      'Total': total,
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
    }).whenComplete(() {
      isLoading = false;
      print('pop');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => btmNavBar(
                    initialIndex: 2,
                  )));
    });
    print('Fucntion called');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Leave this Page?'),
                content: Text(
                    'The Product will be Saved without Any Installments Plans'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  btmNavBar(initialIndex: 2)));
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            });
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(75),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: appBar(
                  title: 'Installments',
                  addIcon: true,
                  onPressedFunction: () {
                    _showAddInstallmentBottomSheet(context);
                  }),
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomGreyText(
                title: 'Installments',
              ),
              InstallmentSection(
                productId: widget.productId,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: isLoading
                    ? const SpinKitDualRing(
                        color: primaryBlue,
                        lineWidth: 3,
                        size: 32,
                      )
                    : PrimaryBtn(
                        btntxt: 'Update',
                        onPressedFunction: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      btmNavBar(initialIndex: 2)));
                          final snackBar = const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('PLAN ADDED Succesfuly'),
                            backgroundColor: Colors.green,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          setState(() {
                            isLoading = false;
                          });

                          downPaymentController.clear();
                          monthsController.clear();
                          planNameController.clear();
                          monthlyInsController.clear();
                        },
                        width: size.width * 0.8,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUseableTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hinttxt;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  const ReUseableTextForm(
      {super.key,
      required this.controller,
      required this.hinttxt,
      required this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      style: customTextblack.copyWith(fontSize: size.width * 0.03),
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(),
      decoration: InputDecoration(
          hintText: hinttxt, contentPadding: const EdgeInsets.all(0)),
    );
  }
}

class ReUseableTextFormText extends StatelessWidget {
  final TextEditingController controller;
  final String hinttxt;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  const ReUseableTextFormText(
      {super.key,
      required this.controller,
      required this.hinttxt,
      required this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      style: customTextblack.copyWith(fontSize: size.width * 0.03),
      controller: controller,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: hinttxt, contentPadding: const EdgeInsets.all(0)),
    );
  }
}
