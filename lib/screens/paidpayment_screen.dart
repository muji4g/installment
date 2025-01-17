import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/granter_info.dart';

import 'package:installement1_app/widgets/userPaid_info_cards.dart';

class PaidPayment extends StatefulWidget {
  const PaidPayment({super.key});

  @override
  State<PaidPayment> createState() => _PaidPaymentState();
}

class _PaidPaymentState extends State<PaidPayment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: size.width * 0.5,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Generate Installment',
                        style: customTextblue.copyWith(
                            fontSize: size.width * 0.04),
                      ))),
              PrimaryBtn(
                  btntxt: 'Add Payment',
                  onPressedFunction: () {},
                  width: size.width * 0.35),
            ],
          ),
        ),
        backgroundColor: bgColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: AppBarSecondary(
                showLeading: true,
                showMenu: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                isarrowLeading: true,
                title: 'Customer Details'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.012,
              ),
              Text(
                'Customer Info',
                style: customTextgrey.copyWith(
                    fontSize: size.width * 0.03, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              const CustomerInfoCardPaid(),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Granter Info',
                style: customTextgrey.copyWith(
                    fontSize: size.width * 0.03, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              const GranterInfoCard(),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Product Info',
                style: customTextgrey.copyWith(
                    fontSize: size.width * 0.03, fontWeight: FontWeight.bold),
              ),
              const ProductInfo(),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Installment Plan',
                style: customTextgrey.copyWith(
                    fontSize: size.width * 0.03, fontWeight: FontWeight.bold),
              ),
              const InstallmentPlan()
            ],
          ),
        ));
  }
}
