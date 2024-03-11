import 'package:flutter/material.dart';

class PaymentOverDue extends StatefulWidget {
  const PaymentOverDue({super.key});

  @override
  State<PaymentOverDue> createState() => _PaymentOverDueState();
}

class _PaymentOverDueState extends State<PaymentOverDue> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('OverDue Payment Screen'),
      ),
    );
  }
}
