import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/add_customer_widgets.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: PrimaryBtn(
            backgroundColor: white,
            btntxt: 'Add',
            onPressedFunction: () {},
            width: size.width * 0.02),
      ),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            const CustomGreyText(title: 'Customer Info'),
            const AddCustomerInfoCard(),
            SizedBox(
              height: size.height * 0.02,
            ),
            const CustomGreyText(title: 'Granter Info'),
            const AddGranterInfo(),
          ],
        ),
      ),
    );
  }
}
