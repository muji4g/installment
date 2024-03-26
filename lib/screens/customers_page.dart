import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:installement1_app/screens/add_customer.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/ListTile.dart';
import 'package:installement1_app/widgets/appbar.dart';

import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/search_bar.dart';
// import 'package:provider/provider.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  bool activeUser = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      // bottomNavigationBar: const btmNavBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: Padding(
            padding:
                EdgeInsets.only(top: size.width * 0.011, left: 12, right: 12),
            child: appBar(
              title: 'Customers',
              addIcon: true,
              onPressedFunction: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCustomer()));
              },
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSearchBar(
              onChanged: (value) {},
              hintText: 'Search Customers',
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: Opacity(
                opacity: 0.4,
                child: Text(
                  'Customer List',
                  style: customTextblack.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              children: [
                customButton(
                  activeUser: activeUser,
                  btnText: 'Active',
                  btnColor: activeUser ? primaryBlue : Colors.white,
                  btntxtcolor: activeUser ? Colors.white : Colors.grey,
                  onpressedfunction: () {
                    setState(() {
                      activeUser = !activeUser;
                    });
                  },
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                customButton(
                  onpressedfunction: () {
                    setState(() {
                      activeUser = !activeUser;
                    });
                  },
                  activeUser: activeUser,
                  btntxtcolor: activeUser ? Colors.grey : Colors.white,
                  btnText: 'Deactive',
                  btnColor: activeUser ? Colors.white : primaryBlue,
                ),
              ],
            ),
            activeUser ? ActiveCustomerList() : deactiveUser(),
          ],
        ),
      ),
    );
  }
}
