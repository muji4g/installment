// ignore_for_file: prefer_const_declarations

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:installement1_app/screens/product_details.dart';

import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

import 'package:installement1_app/widgets/buttons.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:installement1_app/widgets/categoryBottomSheet.dart';

class CategoryList extends StatefulWidget {
  final Function(String) onCategorySelected;
  const CategoryList({
    Key? key,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('categories')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Category> categories = snapshot.data!.docs
              .map((doc) => Category.fromSnapshot(doc))
              .toList();
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildCategoryWidget(Icons.add, 'Add', () {
                    _showAddCategoryBottomSheet(context);
                  }, 'Add');
                } else if (index == 1) {
                  return _buildCategoryWidget(Icons.image, 'All', () {
                    widget.onCategorySelected('');
                    print('onTap Called');
                  }, 'All');
                } else {
                  Category category = categories[index - 2];
                  return _buildCategoryWidget(Icons.image, category.title, () {
                    widget.onCategorySelected(category.categoryID);
                    print('onTap Called');
                  }, category.categoryImage);
                }
              },
            ),
          );
        } else {
          return const SpinKitDualRing(
            lineWidth: 2,
            color: primaryBlue,
            size: 40,
          );
        }
      },
    );
  }

  Widget _buildCategoryWidget(
    IconData iconData,
    String title,
    VoidCallback onTap,
    String imageUrl,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: title == 'All'
                  ? primaryBlue
                  : const Color.fromARGB(255, 255, 255, 255),
              child: title == 'Add'
                  ? Container(
                      width: 50,
                      decoration: const BoxDecoration(
                          color: primaryBlue, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.add,
                        color: white,
                      ))
                  : title == 'All'
                      ? const Icon(
                          FontAwesomeIcons.qrcode,
                          color: white,
                        )
                      : imageUrl.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: 70, // Adjust the width as needed
                                height: 70, // Adjust the height as needed
                              ),
                            )
                          : Icon(iconData),
            ),
            const SizedBox(height: 5),
            Text(title),
          ],
        ),
      ),
    );
  }
}

Future<bool> _checkCategoryExists(String userId, String title) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('users')
      .doc(userId)
      .collection('categories')
      .where('title', isEqualTo: title)
      .limit(1)
      .get();

  return snapshot.docs.isNotEmpty;
}

Future<String> _uploadImage(File imageFile) async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference reference =
      FirebaseStorage.instance.ref().child('images/$fileName');
  UploadTask uploadTask = reference.putFile(imageFile);
  TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
  String downloadURL = await snapshot.ref.getDownloadURL();
  return downloadURL;
}

Future<void> _showAddCategoryBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    barrierColor: primaryBlue.withOpacity(0.3),
    builder: (context) {
      return AddCategoryBottomSheet();
    },
  );
}

Future<void> _addCategoryToFirestore(
    String userId, String title, String imageURL) async {
  DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('categories')
      .doc();

  await docRef.set({
    'title': title,
    'categoryID': docRef.id,
    'Date Added': DateTime.now(),
    'categoryImage': imageURL,
  });
}

///////
class Category {
  final String title;
  final String categoryID;
  String categoryImage;

  Category(this.title, this.categoryID, this.categoryImage);

  Category.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['title'],
        categoryID = snapshot['categoryID'],
        categoryImage = snapshot['categoryImage'];
}

/////This widget is responsible for showing products//////
///
///
class ProductGrid extends StatefulWidget {
  final String selectedCategory;
  final String searchText;

  const ProductGrid({
    Key? key,
    required this.selectedCategory,
    required this.searchText,
  }) : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('products')
            .where(
              'category',
              isEqualTo: widget.selectedCategory.isNotEmpty
                  ? widget.selectedCategory
                  : null,
            )
            .where('titlelowercase',
                isGreaterThanOrEqualTo: widget.searchText.toLowerCase())
            .where('titlelowercase',
                isLessThanOrEqualTo: widget.searchText.toLowerCase() + '\uf8ff')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('ERROR: ${snapshot.error}');
          }

          if (snapshot.hasData) {
            List<Map<String, dynamic>> productsList = snapshot.data!.docs
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList();

            if (productsList.isEmpty) {
              return const Center(
                child: Text(
                  'No products found',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: size.height * 0.01,
                crossAxisSpacing: size.width * 0.017,
              ),
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> productData = productsList[index];
                List<dynamic> images = productData['images'];
                String firstImageUrl = images.isNotEmpty ? images[0] : '';
                String documentId =
                    snapshot.data!.docs[index].id; // Fetching the document ID
                bool installmentPlanExists =
                    productData.containsKey('installmentPlan');

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetails(documentId: documentId),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: size.width * 0.29,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: firstImageUrl.isNotEmpty
                                      ? Image.network(
                                          firstImageUrl,
                                          height: 110,
                                          width: 120,
                                          fit: BoxFit.fill,
                                        )
                                      : const Text('Image Not Found!'),
                                ),
                              ),
                              installmentPlanExists
                                  ? Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: size.height * 0.02,
                                        width: size.width * 0.18,
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.redAccent.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'Add Installment',
                                          style: customTextwhite.copyWith(
                                            fontSize: size.width * 0.02,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                          SizedBox(height: size.height * 0.015),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                Text(
                                  productData['title'],
                                  style: customTextblack.copyWith(
                                      fontSize: size.width * 0.035),
                                ),
                                Text(
                                  ('(' + productData['quantity'] + ')'),
                                  style: customTextgreen.copyWith(
                                      fontSize: size.width * 0.03,
                                      color: productData['quantity'] == '0'
                                          ? Colors.red
                                          : secondaryGreen),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.22),
                            child: Text(
                              textAlign: TextAlign.start,
                              productData['price'].toString(),
                              style: customTextgreen.copyWith(
                                fontSize: size.width * 0.030,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: SpinKitDualRing(
                lineWidth: 2,
                color: Colors.blue,
                size: 35,
              ),
            );
          }
        },
      ),
    );
  }
}

                        





// class ProductGrid extends StatefulWidget {
//   final String selectedCategory;
//   final String searchText;

//   const ProductGrid({
//     Key? key,
//     required this.selectedCategory,
//     required this.searchText,
//   }) : super(key: key);

//   @override
//   State<ProductGrid> createState() => _ProductGridState();
// }

// class _ProductGridState extends State<ProductGrid> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Expanded(
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection('products')
//             .where(
//               'category',
//               isEqualTo: widget.selectedCategory.isNotEmpty
//                   ? widget.selectedCategory
//                   : null,
//             )
//             .where(
//               'title',
//               isGreaterThanOrEqualTo: widget.searchText.toLowerCase(),
//               isLessThanOrEqualTo: '${widget.searchText.toLowerCase()}z',
//             )
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('ERROR: ${snapshot.error}');
//           }

//           if (snapshot.hasData) {
//             List<Map<String, dynamic>> productsList = snapshot.data!.docs
//                 .map((doc) => doc.data() as Map<String, dynamic>)
//                 .toList();

//             if (productsList.isEmpty) {
//               return const Center(
//                 child: Text(
//                   'Add Products',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               );
//             }

//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 1,
//                 mainAxisSpacing: size.height * 0.01,
//                 crossAxisSpacing: size.width * 0.017,
//               ),
//               itemCount: productsList.length,
//               itemBuilder: (context, index) {
//                 Map<String, dynamic> productData = productsList[index];
//                 List<dynamic> images = productData['images'];
//                 String firstImageUrl = images.isNotEmpty ? images[0] : '';
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(4),
//                     child: Column(
//                       children: [
//                         Container(
//                           width: size.width * 0.29,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(32),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(24),
//                             child: InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const ProductDetails(),
//                                     ),
//                                   );
//                                 },
//                                 child: firstImageUrl.isNotEmpty
//                                     ? CachedNetworkImage(
//                                         imageUrl: firstImageUrl,
//                                         height: 100,
//                                         placeholder: (context, url) =>
//                                             const SpinKitPianoWave(
//                                           color: primaryBlue,
//                                           size: 25,
//                                         ),
//                                         errorWidget: (context, url, error) =>
//                                             const Icon(Icons.error),
//                                         fit: BoxFit.fill,
//                                       )
//                                     : const Text('Image Not Found!')),
//                           ),
//                         ),
//                         SizedBox(height: size.height * 0.015),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 12),
//                           child: Row(
//                             children: [
//                               Text(
//                                 productData['title'],
//                                 style: customTextblack,
//                               ),
//                               
//                             ],
//                           ),
//                         ),

//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(
//               child: SpinKitDualRing(
//                 lineWidth: 2,
//                 color: primaryBlue,
//                 size: 40,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
