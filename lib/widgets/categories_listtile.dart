// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installement1_app/widgets/buttons.dart';

class CategoriesList extends StatefulWidget {
  final String searchText;
  const CategoriesList({Key? key, required this.searchText}) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  TextEditingController titleController = TextEditingController();
  File? selectedImage;
  bool isLoading = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void showBottomSheet(
      String categoryID, String currentImageURL, String currentTitle) {
    titleController.text = currentTitle;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      barrierColor: primaryBlue.withOpacity(0.3),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Edit Category',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          pickImage().then((_) {
                            setState(() {});
                          });
                        },
                        child: Container(
                          width: 220,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.grey.withOpacity(0.2),
                            image: selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(selectedImage!),
                                    fit: BoxFit.fill,
                                  )
                                : currentImageURL.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(currentImageURL),
                                        fit: BoxFit.fill,
                                      )
                                    : null,
                          ),
                          child:
                              selectedImage == null && currentImageURL.isEmpty
                                  ? const Icon(Icons.image)
                                  : null,
                        ),
                      ),
                      TextField(
                        controller: titleController,
                        decoration:
                            const InputDecoration(labelText: 'Category Title'),
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const SpinKitDualRing(
                              color: primaryBlue,
                              lineWidth: 2,
                              size: 22,
                            ) // Show circular progress indicator
                          : BottomSheetButton(
                              width: 280,
                              height: 55,
                              btntxt: 'Update',
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await _updateCategory(categoryID,
                                    titleController.text, selectedImage);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('Updated Successfully'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                              }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _updateCategory(
      String categoryID, String title, File? newImage) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('categories')
          .doc(categoryID)
          .update({'title': title});

      // Upload image if new image is selected
      String imageURL = '';
      if (newImage != null) {
        imageURL = await uploadImageToFirebaseStorage(newImage);
      }

      // Update category document with the new image URL
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('categories')
          .doc(categoryID)
          .update({'categoryImage': imageURL});
    } catch (error) {
      print("Error updating category: $error");
    }
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      var storageRef = FirebaseStorage.instance
          .ref()
          .child('category_images')
          .child(
              '${DateTime.now().millisecondsSinceEpoch}-${imageFile.path.split('/').last}');

      // Upload the file to Firebase Storage
      await storageRef.putFile(imageFile);

      // Get the download URL of the uploaded file
      String imageURL = await storageRef.getDownloadURL();

      return imageURL;
    } catch (error) {
      print("Error uploading image to Firebase Storage: $error");
      throw error;
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
            .where('title', isGreaterThanOrEqualTo: widget.searchText)
            .where('title', isLessThanOrEqualTo: widget.searchText + '\uf8ff')
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
            if (productcategories.isEmpty) {
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

            return Expanded(
              child: SizedBox(
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
                            child: Image.network(
                              productData['categoryImage'].toString(),
                              width: 60,
                            ),
                          ),
                          title: Text(
                            productData['title'],
                            style: TextStyle(
                                fontSize: size.width * 0.032,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('products')
                                .where('category', isEqualTo: categoryID)
                                .get(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> productSnapshot) {
                              if (productSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  'Loading....',
                                  style: customTextgrey.copyWith(fontSize: 12),
                                );
                              } else if (productSnapshot.hasData) {
                                int itemCount =
                                    productSnapshot.data!.docs.length;
                                return Text(
                                  '$itemCount items',
                                  style: TextStyle(
                                      fontSize: size.width * 0.032,
                                      color: primaryBlue),
                                );
                              } else {
                                return Text(
                                  'Error',
                                  style: TextStyle(
                                      fontSize: size.width * 0.032,
                                      color: primaryBlue),
                                );
                              }
                            },
                          ),
                          trailing: SizedBox(
                            width: size.width * 0.34,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      showBottomSheet(
                                          categoryID,
                                          productData['categoryImage']
                                              .toString(),
                                          productData['title']);
                                    },
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontSize: size.width * 0.03,
                                          color: primaryBlue),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: white,
                                              title: Text(
                                                'Delete Category?',
                                                style: customTextblack,
                                              ),
                                              content: Text(
                                                  'Are you sure you want to Delete this category?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      _deleteCategory(
                                                          categoryID);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        duration: Duration(
                                                            seconds: 2),
                                                        content: Text(
                                                            'Category Deleted Successfuly'),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ));
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('YES')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('NO'))
                                              ],
                                            );
                                          });
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          fontSize: size.width * 0.03,
                                          color: Colors.red),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const SpinKitCircle(
              color: primaryBlue,
              size: 32,
            );
          }
        });
  }
}
