import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

// import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/model/customer_model.dart';
import 'package:installement1_app/model/features_model.dart';
import 'package:installement1_app/screens/customers_page.dart';
import 'package:installement1_app/screens/dashboard_page.dart';
import 'package:installement1_app/screens/notfound_screen.dart';
import 'package:installement1_app/screens/paidpayment_screen.dart';
import 'package:installement1_app/screens/paymentoverdue_screen.dart';
import 'package:installement1_app/screens/pendingpayment_screen.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/theme/TextStyle.dart';

//this listtile is responsible for user info///
class ListtileUser extends StatefulWidget {
  const ListtileUser({super.key});

  @override
  State<ListtileUser> createState() => _ListtileUserState();
}

class _ListtileUserState extends State<ListtileUser> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        ListTile(
          title: Text(
            'Dashboard',
            style: customTextwhite.copyWith(
                fontSize: size.width * 0.055, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: secondaryBlue,
            child: SvgPicture.asset('assets/images/profilePicture.svg'),
          ),
          title: Text(
            'Al-Afzal Electronics',
            style: customTextwhite.copyWith(fontSize: size.width * 0.04),
          ),
          subtitle: Row(
            children: [
              const Icon(
                FontAwesomeIcons.locationDot,
                color: secondaryBlue,
                size: 16,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text(
                'Islamabad I-10 ',
                style: customTextsubtxt.copyWith(fontSize: size.width * 0.035),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ListtileFeatures extends StatefulWidget {
  // final String primaryText;
  // final String primaryValue;
  // final String secondaryText;
  // final String status;
  // final SvgPicture? picture;
  const ListtileFeatures({
    super.key,
  });

  @override
  State<ListtileFeatures> createState() => _ListtileFeaturesState();
}

/////////////////////////////////////
//The features Section in Dashboard
class _ListtileFeaturesState extends State<ListtileFeatures> {
//Recent Features List Tiles!!!
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: features.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 12, left: 17, right: 17),
            child: Container(
              height: size.height * 0.1,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(
                        17, 0, 0, 0), // Use color value in RGBA format
                    blurRadius: 20,
                    spreadRadius: 0, // Adjust blur radius as needed
                    offset: Offset(0, 4), // Adjust offset as needed
                  )
                ],
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Center(
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: features[index].picture,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(features[index].title,
                          style: customTextblack.copyWith(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold)),
                      Text(
                        features[index].value,
                        style: customTextblack.copyWith(
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        features[index].subtitle,
                        style: customTextgrey.copyWith(
                            fontSize: size.width * 0.03),
                      ),
                      Text(features[index].subText,
                          style: customTextgrey.copyWith(
                              fontSize: size.width * 0.03)),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

// need to change using Provider State!!!!
//Active Customers List Tiles

class ActiveCustomerList extends StatefulWidget {
  const ActiveCustomerList({
    super.key,
  });

  @override
  State<ActiveCustomerList> createState() => _ActiveCustomerListState();
}

class _ActiveCustomerListState extends State<ActiveCustomerList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
        itemCount: customerList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 9,
            ),
            child: Container(
              height: size.height * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                  bool isPaid = customerList[index].isPaid;
                  bool isPending = customerList[index].isPending;
                  bool isOverdue = customerList[index].isOverdue;
                  // dynamic paidpayment = Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PaidPayment()),
                  // );
                  if (isPaid == true &&
                      isPending == false &&
                      isOverdue == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaidPayment()),
                    );
                  } else if (isPaid == false &&
                      isPending == true &&
                      isOverdue == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PendingPayments()),
                    );
                  } else if (isPaid == false &&
                      isPending == false &&
                      isOverdue == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentOverDue()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotFound()),
                    );
                  }
                },
                child: ListTile(
                  title: Text(
                    customerList[index].customerName,
                    style: customTextblack.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.037),
                  ),
                  subtitle: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer ID :' + customerList[index].customerID,
                            style: customTextblue.copyWith(
                                fontSize: size.width * 0.032),
                          ),
                          // Status Container Paid,overdue with decoration
                          Container(
                            width: customerList[index].status == 'paid'
                                ? size.width * 0.256
                                : size.width * 0.18,
                            height: size.height * 0.045,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: customerList[index].status == 'paid'
                                    ? const Color(0xffDDE9FD)
                                    : customerList[index].status == 'pending'
                                        ? const Color(0xffFFF9E8)
                                        : const Color(0xffFEC6C6)),
                            child: Center(
                              child: customerList[index].status == 'pending'
                                  ? Text(
                                      'Pending',
                                      style: TextStyle(
                                          color: const Color(0xffFBBC05),
                                          fontSize: size.width * 0.026,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : customerList[index].status == 'paid'
                                      ? Text(
                                          'Paid 12 April 2023',
                                          style: customTextblue.copyWith(
                                              fontSize: size.width * 0.026,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : Text('OverDue',
                                          style: customTextred.copyWith(
                                              fontSize: size.width * 0.026,
                                              fontWeight: FontWeight.w600)),
                            ),
                          )
                        ]),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 12,
                          ),
                          Text(
                            customerList[index].customerAddress,
                            style: customTextblack.copyWith(
                                fontSize: size.width * 0.032),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  // SizedBox(
                  //   height: size.height * .01,
                  // ),
                ),
              ),
            ),
          );
        });
  }
}

//Non Active User
class deactiveUser extends StatefulWidget {
  const deactiveUser({super.key});

  @override
  State<deactiveUser> createState() => _deactiveUserState();
}

class _deactiveUserState extends State<deactiveUser> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: features.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.only(right: 17),
              child: Container(
                height: size.height * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: Text(
                    deactivecustomerList[index].customerName,
                    style: customTextblack.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.045),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        'Customer ID :' +
                            deactivecustomerList[index].customerID,
                      ),
                      Text(
                        deactivecustomerList[index].customerAddress,
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}


// class ActiveCustomerList extends StatefulWidget {
//   const ActiveCustomerList({super.key});

//   @override
//   State<ActiveCustomerList> createState() => _ActiveCustomerListState();
// }

// class _ActiveCustomerListState extends State<ActiveCustomerList> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12, left: 17, right: 17),
//       child: ListView.builder(
//           itemCount: customerList.length,
//           shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               child: Expanded(
//                 child: ListTile(
//                   title: Text(customerList[index].customerName),
//                   subtitle: Column(
//                     children: [
//                       Text(customerList[index].customerID),
//                       Text(customerList[index].customerAddress),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }

//Non Active Customer List Tile
// class NonActiveCustomer extends StatefulWidget {
//   const NonActiveCustomer({super.key});

//   @override
//   State<NonActiveCustomer> createState() => _NonActiveCustomerState();
// }

// class _NonActiveCustomerState extends State<NonActiveCustomer> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: deactivecustomerList.length,
//         shrinkWrap: true,
//         scrollDirection: Axis.vertical,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(deactivecustomerList[index].customerName),
//             subtitle: Column(
//               children: [
//                 Text(deactivecustomerList[index].customerID),
//                 Text(deactivecustomerList[index].customerAddress),
//               ],
//             ),
//           );
//         });
//   }
// }
