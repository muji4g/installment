import 'package:flutter/material.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBarSecondary(
              showMenu: false,
              isarrowLeading: false,
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'Add Customers')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
