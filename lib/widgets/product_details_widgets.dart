// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/model/installments_model.dart';
import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/screens/installmentpage_section.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/buttons.dart';

class BlueContainerRow extends StatelessWidget {
  const BlueContainerRow({
    super.key,
  });

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
                value, //number of months
                style: customTextblack.copyWith(fontSize: size.width * 0.04),
              ),
              SizedBox(
                width: size.width * 0.007,
              ),
              Text(
                label, //
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
  final String documentId;
  const InstallmentPlanSection({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('products')
            .doc(documentId)
            .collection('installmentPlan')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitDualRing(
              color: primaryBlue,
              lineWidth: 3,
              size: 32,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<DocumentSnapshot> installments = snapshot.data!.docs;
            if (installments.isEmpty) {
              return Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(18)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No Installments Found!!',
                      style:
                          customTextblack.copyWith(fontSize: size.width * 0.05),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InstallmentPlan(
                                        productId: documentId,
                                      )));
                        },
                        icon: Icon(
                          FontAwesomeIcons.plus,
                          color: primaryBlue,
                        )),
                    Text('Add')
                  ],
                ),
              );
            }
            return Container(
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const BlueContainerRow(),
                    ),
                    SizedBox(
                      height: size.height * 0.22,
                      child: ListView.builder(
                          itemCount: installments.length,
                          itemBuilder: ((context, index) {
                            String months = installments[index]['months'];
                            String monthlyInstallment =
                                installments[index]['monthlyInstallment'];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.005,
                                  horizontal: size.width * 0.01),
                              child: Column(
                                children: [
                                  InstallmentDetailRow(
                                      label: 'Months',
                                      value: months,
                                      text: monthlyInstallment),
                                ],
                              ),
                            );
                          })),
                    ),
                  ],
                ));
          }
        });
  }
}

//////////////////////////////////////////////
////////About Product Detail/////////////////
/////////////////////////////////////////////

class AboutProduct extends StatelessWidget {
  final String userId; // User ID to fetch data
  final String productId; // Product ID to fetch data

  const AboutProduct({
    Key? key,
    required this.userId,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('products')
          .doc(productId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var data = snapshot.data!.data();
          if (data != null) {
            return Container(
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  data['description'],
                  style: customTextblack.copyWith(
                      fontSize: 16), // Adjust font size as needed
                ),
              ),
            );
          }
        }
        return SizedBox(); // Return an empty widget if data is not available
      },
    );
  }
}
