// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:installement1_app/screens/Dashboard.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   // ADDED THIS
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     bool isHomeScreen = false;
//     bool isCustomersScreen = false;

//     Size size = MediaQuery
//         .of(context)
//         .size;
//     return Padding(
//       padding: EdgeInsets.only(
//           left: size.width * 0.04,
//           right: size.width * 0.06,
//           bottom: size.width * 0.06),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(27),),
//         height: size.height * 0.07,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           // ADDED THIS
//           children: buildIcons(),
//         ),
//       ),
//     );
//   }

//   List<Widget> buildIcons() {
//     final list = <Widget>[];

//     final icons = <String>[
//       SvgPicture.asset('assets/images/')
//     ];

//     for (var index = 0; index <= icons.length; index++) {
//       list.add(IconButton(
//         onPressed: () => onChange(index),
//         icon: SvgPicture.asset(icons[index]),
//       ),);
//     }

//     return list;
//   }

//   void onChange(int change) {
//     if (selectedIndex != change) {
//       selectedIndex = change;
//       switch (change) {
//       // ADD YOUR ROUTING FUNCTIONALITY HERE
//       // EXAMPLE
//         case 0:
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => DashboardScreen()));
//           break;
//       }
//     }
//   }
// }