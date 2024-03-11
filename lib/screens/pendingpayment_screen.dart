import 'package:flutter/material.dart';

class PendingPayments extends StatefulWidget {
  const PendingPayments({super.key});

  @override
  State<PendingPayments> createState() => _PendingPaymentsState();
}

class _PendingPaymentsState extends State<PendingPayments> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Pending Payments'),
      ),
    );
  }
}
