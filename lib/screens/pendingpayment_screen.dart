import 'package:flutter/material.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/granter_info.dart';
import 'package:installement1_app/widgets/userUNpaid_info_cards.dart';

class PendingPayments extends StatefulWidget {
  const PendingPayments({super.key});

  @override
  State<PendingPayments> createState() => _PendingPaymentsState();
}

class _PendingPaymentsState extends State<PendingPayments> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: PrimaryBtn(
            btntxt: 'Generate Installment',
            onPressedFunction: () {},
            width: size.width * 0.2),
      ),
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBarSecondary(
              showLeading: true,
              showMenu: true,
              isarrowLeading: true,
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'Customer Details')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            const GreyText(text: 'Customer Info'),
            SizedBox(
              height: size.height * 0.01,
            ),
            const CustomerInfoCardUnpaid(),
            SizedBox(
              height: size.height * 0.02,
            ),
            const GreyText(text: 'Granter Info'),
            SizedBox(
              height: size.height * 0.01,
            ),
            const GranterInfoCard(),
          ],
        ),
      ),
    );
  }
}
