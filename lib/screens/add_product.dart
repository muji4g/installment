import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/add_products_widgets.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<File> selectedImages = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController decriptionController = TextEditingController();

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
        'installmentPlan': '',
        'images': ''
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
          child: PrimaryBtn(
              btntxt: 'Add Product',
              onPressedFunction: () {
                addProductToFirestore();
              },
              width: size.width * 0.15),
        ),
        backgroundColor: bgColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: AppBarSecondary(
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
                const InstallmentPlanSection(),
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
