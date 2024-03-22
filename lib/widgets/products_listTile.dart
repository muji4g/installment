import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/screens/product_details.dart';

import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

import 'package:installement1_app/widgets/buttons.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              itemCount: categories.length +
                  2, // Additional 2 for 'All' and 'Add' categories
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildCategoryWidget(Icons.image, 'All', () {});
                } else if (index == 1) {
                  return _buildCategoryWidget(Icons.add, 'Add', () {
                    _showAddCategoryBottomSheet(context);
                  });
                } else {
                  Category category = categories[index - 2];
                  return _buildCategoryWidget(
                      Icons.image, category.title, () {});
                }
              },
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildCategoryWidget(
      IconData iconData, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blueGrey,
              child: Icon(iconData),
            ),
            SizedBox(height: 5),
            Text(title),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddCategoryBottomSheet(BuildContext context) async {
    File? selectedImage;

    Size size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    TextEditingController titleController = TextEditingController();

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          selectedImage = File(pickedImage.path);
        });
      }
    }

    // Function to handle image selection from camera

    if (user != null) {
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        barrierColor: primaryBlue.withOpacity(0.3),
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Category',
                    style: customTextblack.copyWith(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    width: size.width * 0.8,
                    height: size.height * 0.25,
                    child: InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selectedImage != null
                              ? Image.file(
                                  selectedImage!,
                                  fit: BoxFit.contain,
                                )
                              : Icon(Icons.image),
                          Text('Upload An Image'),
                        ],
                      ),
                    ),
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Category Title'),
                  ),
                  SizedBox(height: 20),
                  BottomSheetButton(
                      btntxt: 'Add',
                      onPressed: () async {
                        DocumentReference<Map<String, dynamic>> docRef =
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .collection('categories')
                                .doc();

                        await docRef.set({
                          'title': titleController.text,
                          'categoryID': docRef.id,
                          'Date Added': DateTime.now(),
                        });
                        Navigator.pop(context);
                      },
                      width: size.width * 0.7,
                      height: size.height * 0.05)
                ],
              ),
            ),
          );
        },
      );
    }
  }
}

class Category {
  final String title;

  Category(this.title);

  Category.fromSnapshot(DocumentSnapshot snapshot) : title = snapshot['title'];
}

///////////////////////////////
////
/////PRODUCT GRIDS//////////
///////////////////
class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  List<Map<String, dynamic>> productsList = [];
  String productTitle = '';
  String productQuantity = '';
  String productPrice = '';

  void initState() {
    super.initState();
    fetchProductDetails();
    // TODO: implement initState
    setState(() {});
  }

  void fetchProductDetails() async {
    int index;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .collection('products')
          .get();

      if (snapshot.size > 0) {
        setState(() {
          productsList = snapshot.docs.map((doc) => doc.data()).toList();
        });
        Map<String, dynamic> productData = snapshot.docs[0].data();
        productTitle = productData['title'];

        productPrice = productData['price'];
        productQuantity = productData['quantity'];

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.88,
              mainAxisSpacing: size.height * 0.01,
              crossAxisSpacing: size.width * 0.017),
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> productData = productsList[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32)),
                      // height: size.height * 0.18,
                      // width: size.width * 0.5,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails()));
                            },
                            child: Image.asset(
                              'assets/images/iphoneImage.png',
                            ),
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          Text(
                            productData['title'],
                            style: customTextblack,
                          ),
                          Text(
                            ('' + productData['quantity'] + ''),
                            style: customTextblack,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.2),
                      child: Text(productData['price'],
                          style: customTextgreen.copyWith(
                              fontSize: size.width * 0.030,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
