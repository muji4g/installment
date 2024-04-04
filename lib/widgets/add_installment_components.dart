// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

class InstallmentSection extends StatefulWidget {
  final String productId;
  const InstallmentSection({Key? key, required this.productId});

  @override
  State<InstallmentSection> createState() => _InstallmentSectionState();
}

class _InstallmentSectionState extends State<InstallmentSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('products')
            .doc(widget.productId)
            .collection('installmentPlan')
            .orderBy('months', descending: false)
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
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * .3),
                  child: Text(
                    'No Installments Found',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: installments.map((installment) {
                String planName = installment['planName'];
                String months = installment['months'];
                String downPayment = installment['downPayment'];
                String monthlyInstallment = installment['monthlyInstallment'];

                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 209, 208, 208)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.03,
                          vertical: size.height * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReUseAbleRow(
                            text: 'Plan Name',
                            fetcheddata: planName,
                          ),
                          ReUseAbleRow(
                            text: 'Duration In Months',
                            fetcheddata: months,
                          ),
                          ReUseAbleRow(
                            text: 'Down Payment',
                            fetcheddata: downPayment,
                          ),
                          ReUseAbleRow(
                            text: 'Monthly Installment',
                            fetcheddata: monthlyInstallment,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        });
  }
}

class ReUseAbleRow extends StatelessWidget {
  final String text;
  final String fetcheddata;

  const ReUseAbleRow({
    Key? key,
    required this.text,
    required this.fetcheddata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          textAlign: TextAlign.start,
        ),
        Text(fetcheddata, textAlign: TextAlign.start)
      ],
    );
  }
}
