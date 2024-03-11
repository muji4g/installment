import 'package:flutter/gestures.dart';

class InstallmentsModel {
  final double amount;
  final String installmentPlan;
  final List installemtnPlanwords;
  // final double durationnum;
  final List planMonths;
  // final double monthlyPayment;
  // final String durationWords;
  final bool isPaid;
  final double total;
  // final String monthPaid;
  final String paymentDate;
  InstallmentsModel({
    required this.amount,

    // required this.durationWords,
    // required this.monthlyPayment,
    required this.isPaid,
    // required this.monthPaid,
    required this.planMonths,
    required this.installmentPlan,
    required this.paymentDate,
    required this.installemtnPlanwords,
  }) : total = amount * 3;
}

List<InstallmentsModel> installments = [
  InstallmentsModel(
      amount: 16500,
      installmentPlan: '3',
      installemtnPlanwords: ['Months', 'Years'],
      planMonths: ['October', 'November', 'December'],
      isPaid: true,
      paymentDate: '12 April'),
  InstallmentsModel(
      amount: 16500,
      installmentPlan: '3',
      installemtnPlanwords: ['Months', 'Years'],
      planMonths: ['October', 'November', 'December'],
      isPaid: true,
      paymentDate: '12 April'),
  InstallmentsModel(
      amount: 16500,
      installmentPlan: '3',
      installemtnPlanwords: ['Months', 'Years'],
      planMonths: ['October', 'November', 'December'],
      isPaid: true,
      paymentDate: '12 April'),
];
