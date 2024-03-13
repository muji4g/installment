import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/widgets/ListTile.dart';
import 'package:installement1_app/widgets/bottomNavbar.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/statisticsContainer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final String date = 'March 2024';
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        // bottomNavigationBar: const btmNavBar(),
        backgroundColor: const Color(0xffF6F6F6),
        body: Stack(
          children: [
            Container(
              height: size.height * .4,
              decoration: const BoxDecoration(
                  gradient: lineargradient,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 15.0),
              child: ListtileUser(),
            ),
            Positioned(
              top: size.height * 0.27,
              left: size.width * 0.07,
              child: Row(
                children: [
                  Text('Overall Statistics',
                      style: customTextsubtxt.copyWith(
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: size.width * 0.3,
                  ),
                  InkWell(
                    onTap: () {
                      // CalendarDatePicker(
                      //   initialDate: date as int,
                      //   initialCalendarMode: DatePickerMode.day,
                      // );
                    },
                    child: Row(
                      children: [
                        Text(date,
                            style: customTextsubtxt.copyWith(
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        const Icon(
                          FontAwesomeIcons.solidCalendar,
                          color: secondaryBlue,
                          size: 16,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: size.height * .32,
              left: size.width * .04,
              child: Row(
                children: [
                  StatisticsContainer(
                    totalNumber: '100',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * .055),
                    secondaryText: 'Total',
                    secondarystyle: TextStyle(
                        color: secondaryBlue, fontSize: size.width * 0.03),
                    containerColor: const Color(0xff3C67D6),
                    type: 'Customers',
                    typestyle: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.036),
                  ),
                  StatisticsContainer(
                    totalNumber: '10K',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * .055),
                    secondaryText: 'Pending',
                    secondarystyle: TextStyle(
                        color: Color(0xffB9A2D6), fontSize: size.width * 0.03),
                    containerColor: const Color(0xff7244AD),
                    type: 'Payments',
                    typestyle: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.036),
                  ),
                  StatisticsContainer(
                    totalNumber: '1000',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * .055),
                    secondaryText: 'Complete',
                    secondarystyle: TextStyle(
                        color: Colors.grey, fontSize: size.width * 0.03),
                    containerColor: Colors.white,
                    type: 'Orders',
                    typestyle: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: size.width * 0.036),
                  ),
                ],
              ),
            ),
            Positioned(
              top: size.height * 0.516,
              left: size.width * 0.07,
              child: Text(
                'Recent Features',
                style: customTextblack.copyWith(
                    fontWeight: FontWeight.bold, fontSize: size.width * 0.038),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.5,
              ),
              child: const ListtileFeatures(),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: size.height * 0.61),
            //   child: ListtileFeatures(),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: size.height * 0.72),
            //   child: ListtileFeatures(),
            // ),
          ],
        ),
      ),
    );
  }
}
