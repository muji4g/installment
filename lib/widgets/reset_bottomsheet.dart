// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:installement1_app/theme/TextStyle.dart';
// import 'package:installement1_app/theme/app_colors.dart';
// import 'package:installement1_app/widgets/buttons.dart';

// class ResetPasswordBottomSheet extends StatefulWidget {
//   final TextEditingController resetPassController;
//   final String resetMessage;
//   final VoidCallback onPressed;

//   const ResetPasswordBottomSheet({
//     Key? key,
//     required this.resetPassController,
//     required this.resetMessage,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   State<ResetPasswordBottomSheet> createState() =>
//       _ResetPasswordBottomSheetState();
// }

// class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return TextBtn(
//       btntxt: 'Reset Password?',
//       fontsize: 0.035,
//       onPressedFunction: () {
//         _showResetPasswordBottomSheet(context);
//       },
//     );
//   }

//   void _showResetPasswordBottomSheet(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     showModalBottomSheet<void>(
//       isScrollControlled: true,
//       context: context,
//       backgroundColor: Colors.transparent, // Make the background transparent
//       builder: (context) => Container(
//         // Wrap content in a container
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30), color: white),
//         child: BackdropFilter(
//           // Apply the filter to the content only
//           filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: size.height * 0.03,
//               horizontal: size.width * 0.1,
//             ),
//             child: SingleChildScrollView(
//               padding: MediaQuery.of(context).viewInsets,
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Text(
//                     'Reset Password',
//                     style: TextStyle(
//                       fontSize: size.width * 0.04,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: size.height * 0.01),
//                   Text(
//                     widget.resetMessage,
//                     style:
//                         customTextgrey.copyWith(fontSize: size.width * 0.025),
//                   ),
//                   SizedBox(height: size.height * 0.015),
//                   TextField(
//                     controller: widget.resetPassController,
//                     decoration: const InputDecoration(
//                         hintText: 'EMAIL', contentPadding: EdgeInsets.all(10)),
//                   ),
//                   SizedBox(height: size.height * 0.02),
//                   PrimaryBtn(btntxt: 'reset', onPressedFunction: onPressedFunction, width: width)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
