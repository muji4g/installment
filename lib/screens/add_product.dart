import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:installement1_app/screens/installmentpage_section.dart';
import 'package:installement1_app/theme/TextStyle.dart';

import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/add_products_widgets.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/product_details_widgets.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? _selectedCategory;
  Map<String, String> _categories = {};

  List<File> selectedImages = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController decriptionController = TextEditingController();

  Future<void> fetchCategories() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .collection('categories')
        .get();

    //fetching the items of categories as String:
    Map<String, String> categories = {};
    querySnapshot.docs.forEach((doc) {
      categories[doc.id] = doc['title'];
    });
    setState(() {
      _categories = categories;
    });
  }

  Future<void> updateSelectedCategory(String selectedCategory) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'selectedCategory': selectedCategory});

    // upadtes the dropdown ui
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  void addSelectedImage(File image) {
    setState(() {
      selectedImages.add(image);
    });
  }

  void removeSelectedImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  void addProductToFirestore() {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      CollectionReference products = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('products');
      Map<String, dynamic> productData = {
        'title': titleController.text,
        'price': priceController.text,
        'quantity': quantityController.text,
        'description': decriptionController.text,
        'images': '',
        'selectedCategory': _selectedCategory,
      };
      products.add(productData);
      titleController.clear();
      priceController.clear();
      quantityController.clear();
      decriptionController.clear();
      setState(() {
        selectedImages.clear();
      });
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
          child: PrimaryBtn(
              btntxt: 'Add Product',
              onPressedFunction: () {
                addProductToFirestore();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InstallmentPlan(
                              productId: productData.id,
                            )));
                final snackBar = SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Product added'),
                  backgroundColor: Colors.green,
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              width: size.width * 0.15),
        ),
        backgroundColor: bgColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: AppBarSecondary(
                showLeading: true,
                showMenu: false,
                onPressed: () {
                  Navigator.pop(context);
                },
                isarrowLeading: false,
                title: 'Add Product'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.025,
                ),
                LowOpacityText(text: 'Upload Image'),
                SizedBox(
                  height: size.height * 0.017,
                ),
                ImageAdd(
                  onImageSelected: addSelectedImage,
                  onImageRemoved: removeSelectedImage,
                  selectedImages: selectedImages,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LowOpacityText(text: 'Select Category'),
                    DropdownButton<String>(
                      style: customTextblack.copyWith(fontSize: 14),
                      value: _selectedCategory,
                      hint: Text(
                        'Select Product Category',
                        style: customTextgrey.copyWith(fontSize: 12),
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          // Update the selected category
                          updateSelectedCategory(newValue);
                        }
                      },
                      items: _categories.entries.map<DropdownMenuItem<String>>(
                          (MapEntry<String, String> entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                const LowOpacityText(text: 'Product Info'),
                SizedBox(
                  height: size.height * 0.011,
                ),
                ProductInfo(
                  titlecontroller: titleController,
                  pricecontroller: priceController,
                  quantitycontroller: quantityController,
                  title: 'Title.',
                  price: 'Total Price.',
                  quantity: 'Quantity.',
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const LowOpacityText(text: 'Installment Plan'),
                SizedBox(
                  height: size.height * 0.011,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const LowOpacityText(text: 'About Product'),
                SizedBox(
                  height: size.height * 0.011,
                ),
                Description(
                  descriptioncontroller: decriptionController,
                ),
              ],
            ),
          ),
        ));
  }
}
