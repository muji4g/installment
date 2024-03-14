import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/granter_info.dart';
import 'package:installement1_app/widgets/info_cards_edit.dart';

class EditCustomerPage extends StatefulWidget {
  const EditCustomerPage({super.key});

  @override
  State<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<EditCustomerPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.06),
        child: PrimaryBtn(
            btntxt: 'Save', onPressedFunction: () {}, width: size.width * 1.2),
      ),
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: AppBarSecondary(
              showMenu: false,
              isarrowLeading: false,
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'Edit Customer')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: ListView(
          children: [
            const CustomGreyText(title: 'Customer Info'),
            const EditCustomerInfo(),
            SizedBox(
              height: size.height * 0.02,
            ),
            const CustomGreyText(title: 'Granter Info'),
            const GranterInfoCard(),
          ],
        ),
      ),
    );
  }
}
