import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/widgets/ListTile.dart';
import 'package:installement1_app/widgets/appbar.dart';
import 'package:installement1_app/widgets/payment_list.dart';
import 'package:installement1_app/widgets/search_bar.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: Padding(
            padding:
                EdgeInsets.only(top: size.width * 0.011, left: 12, right: 12),
            child: appBar(
              addIcon: true,
              title: 'Payments',
              onPressedFunction: () {},
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.051),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSearchBar(
              onChanged: (value) {},
              hintText: 'Search Customers',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 0.4,
                    child: Row(
                      children: [
                        Text(
                          'Payment List',
                          style: customTextblack.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.02),
                    child: Row(
                      children: [
                        Text('March 2024',
                            style: customTextblue.copyWith(
                              fontSize: size.width * 0.032,
                            )),
                        SizedBox(
                          width: size.width * 0.001,
                        ),
                        const Icon(
                          FontAwesomeIcons.solidCalendar,
                          color: secondaryBlue,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),

            ///Payments type list
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.02, bottom: size.height * 0.02),
              child: PaymentType(),
            ),

            ///CustomerList
            ActiveCustomerList()
          ],
        ),
      ),
    );
  }
}
