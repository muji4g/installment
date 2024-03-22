// import 'package:flutter/material.dart';

// class ElectronicsPage extends StatelessWidget {
//   const ElectronicsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Electronics'),
//       ),
//     );
//   }
// }

// class MobilesPage extends StatelessWidget {
//   const MobilesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Mobiles'),
//       ),
//     );
//   }
// }
// class CategoryList extends StatefulWidget {
//   const CategoryList({super.key});

//   @override
//   State<CategoryList> createState() => _CategoryList();
// }

// class _CategoryList extends State<CategoryList> {
//   TextEditingController controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(
//       height: size.height * 0.096,
//       child: ListView.builder(
//           itemCount: categoryList.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (_, index) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
//                   child: InkWell(
//                     onTap: () {
//                       if (categoryList[index].categoryType == 'Add') {
//                         showModalBottomSheet<void>(
//                           isScrollControlled: true,
//                           context: context,
//                           barrierColor: primaryBlue.withOpacity(0.3),
//                           builder: (context) => BackdropFilter(
//                             filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(30)),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: size.height * 0.03,
//                                     horizontal: size.width * 0.1),
//                                 child: SingleChildScrollView(
//                                   padding: MediaQuery.of(context).viewInsets,
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Text(
//                                         'Add Category',
//                                         style: customTextblack.copyWith(
//                                             fontSize: size.width * 0.04,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(
//                                         height: size.height * 0.01,
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(28),
//                                           color: Colors.grey.withOpacity(0.2),
//                                         ),
//                                         width: size.width * 0.8,
//                                         height: size.height * 0.25,
//                                         child: InkWell(
//                                           onTap: () {},
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Icon(
//                                                 FontAwesomeIcons.image,
//                                                 size: size.width * 0.1,
//                                                 color: Color(0xffC2C2C2),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Text(
//                                                   'Upload Image',
//                                                   style:
//                                                       customTextgrey.copyWith(
//                                                           fontSize: size.width *
//                                                               0.03),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: size.height * 0.015,
//                                       ),
//                                       TextFieldBottomSheet(
//                                         resetPassController: controller,
//                                         hinttxt: 'Category Name',
//                                       ),
//                                       SizedBox(
//                                         height: size.height * 0.02,
//                                       ),
//                                       BottomSheetButton(
//                                           btntxt: 'Add',
//                                           onPressed: () {
//                                             await FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(user.uid)
//                           .collection('categories')
//                           .add({
//                         'title': titleController.text,
//                       });
//                       Navigator.pop(context);
//                                           },
//                                           width: size.width * 0.7,
//                                           height: size.height * 0.05)
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                     splashColor: primaryBlue,
//                     borderRadius: BorderRadius.circular(55),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: categoryList[index].hasbgColor
//                               ? lineargradient
//                               : null),
//                       child: CircleAvatar(
//                         backgroundColor: categoryList[index].hasbgColor
//                             ? Colors.transparent
//                             : Colors.white,
//                         radius: 25,
//                         child: SvgPicture.asset(
//                           categoryList[index].categoryImage,
//                           width: categoryList[index].hasbgColor
//                               ? size.width * 0.07
//                               : size.width * 0.17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.005,
//                 ),
//                 Text(categoryList[index].categoryType),
//               ],
//             );
//           }),
//     );
//   }
// }