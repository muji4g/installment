import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:installement1_app/model/categories_model.dart';
import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/model/userdetails_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/buttons.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
  });

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  TextEditingController titleController = TextEditingController();

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {}
  }

  void showBottomSheet(categoryID) {
    File? selectedImage;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      barrierColor: primaryBlue.withOpacity(0.3),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Edit Category',
                    style: customTextblack.copyWith(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    width: 220,
                    height: 120,
                    child: InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selectedImage != null
                              ? Image.file(
                                  selectedImage,
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
                      btntxt: 'Update',
                      onPressed: () async {
                        _updatecategory(categoryID, titleController.text);
                      },
                      width: 180,
                      height: 120)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _updatecategory(String categoryID, String title) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('categories')
          .doc(categoryID)
          .update({'title': title});
    } catch (error) {
      print("Error updating category title: $error");
    }
  }

  Future<void> _deleteCategory(String categoryID) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('categories')
          .doc(categoryID)
          .delete();
    } catch (error) {
      print("Error deleting category: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('categories')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitCircle(
              color: primaryBlue,
              size: 32,
            );
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> productcategories = snapshot.data!.docs
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList();

            // List<DocumentSnapshot> userDocs = snapshot.data!.docs;

            return SizedBox(
              height: size.height * 0.7,
              child: ListView.builder(
                itemCount: productcategories.length,
                itemBuilder: (context, index) {
                  String categoryID = snapshot.data!.docs[index].id;
                  Map<String, dynamic> productData = productcategories[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: size.height * 0.095,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14)),
                      child: ListTile(
                        leading: Container(
                          child: Icon(Icons.image),
                        ),
                        title: Text(
                          productData['title'],
                          style: customTextblack.copyWith(
                              fontSize: size.width * 0.032,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '100 ' + 'items',
                          style: customTextblue.copyWith(
                              fontSize: size.width * 0.032),
                        ),
                        trailing: SizedBox(
                          width: size.width * 0.34,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    ////bottomsheet/////
                                    showBottomSheet(categoryID);
                                  },
                                  child: Text(
                                    'Edit',
                                    style: customTextblue.copyWith(
                                        fontSize: size.width * 0.03),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    await _deleteCategory(categoryID);
                                  },
                                  child: Text(
                                    'Delete',
                                    style: customTextred.copyWith(
                                        fontSize: size.width * 0.03),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return SpinKitCircle(
              color: primaryBlue,
              size: 32,
            );
          }
        });
  }
}
