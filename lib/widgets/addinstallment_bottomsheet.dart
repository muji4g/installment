import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/buttons.dart';

class AddInstallmentBottomSheet extends StatefulWidget {
  final TextEditingController planController;
  final TextEditingController monthsController;
  final TextEditingController downPaymentController;
  final TextEditingController monthlyInstallmentController;
  final String productId;

  const AddInstallmentBottomSheet({
    Key? key,
    required this.planController,
    required this.monthsController,
    required this.monthlyInstallmentController,
    required this.downPaymentController,
    required this.productId,
  }) : super(key: key);

  @override
  _AddInstallmentBottomSheetState createState() =>
      _AddInstallmentBottomSheetState();
}

class _AddInstallmentBottomSheetState extends State<AddInstallmentBottomSheet> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  Future<void> _addInstallment() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Access the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Add installment plan data to Firebase
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('products')
          .doc(widget.productId)
          .collection('installmentPlan')
          .add({
        'planName': widget.planController.text,
        'months': widget.monthsController.text,
        'downPayment': widget.downPaymentController.text,
        'monthlyInstallment': widget.monthlyInstallmentController.text,
        // You can add more fields as needed
      });

      // Close the bottom sheet
      Navigator.pop(context);
    } catch (error) {
      print('Error adding installment: $error');
      setState(() {
        isLoading = false;
      });
    }
    widget.planController.clear();
    widget.monthsController.clear();
    widget.downPaymentController.clear();
    widget.monthlyInstallmentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Installments',
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field Cannot be Empty';
                          }
                          return null;
                        },
                        controller: widget.planController,
                        decoration:
                            const InputDecoration(labelText: 'Plan Name'),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field Cannot be Empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: widget.monthsController,
                        decoration: const InputDecoration(labelText: 'Months'),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field Cannot be Empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: widget.downPaymentController,
                        decoration:
                            const InputDecoration(labelText: 'Down Payment'),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field Cannot be Empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: widget.monthlyInstallmentController,
                        decoration: const InputDecoration(
                            labelText: 'Monthly Installment'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? SpinKitDualRing(
                        lineWidth: 2,
                        color: primaryBlue,
                        size: 40,
                      )
                    : PrimaryBtn(
                        btntxt: 'Add Installment',
                        onPressedFunction: _addInstallment,
                        width: size.width * 0.5,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
