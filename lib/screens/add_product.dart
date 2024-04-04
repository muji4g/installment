import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installement1_app/controller/add_product_controller.dart';
import 'package:installement1_app/model/addproduct_model.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/add_products_widgets.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/product_details_widgets.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final AddProductController _controller =
      AddProductController(AddProductModel());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleLowercaseController =
      TextEditingController();
  final TextEditingController titleuppercaseController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKeyDescription = GlobalKey<FormState>();
  List<File> selectedImages = [];
  String? _selectedCategory;
  Map<String, String> _categories = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _controller.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> _uploadImagesAndAddProduct() async {
    if (selectedImages.isEmpty || _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Image And Category can not Empty'),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (!formKeyDescription.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    List<String> imageUrls = [];
    for (var imageFile in selectedImages) {
      Reference reference = FirebaseStorage.instance.ref();
      String filename = DateTime.now().millisecond.toString();
      Reference referenceImageRoot = reference.child('images');
      Reference imageUpload = referenceImageRoot.child(filename);
      try {
        await imageUpload.putFile(imageFile);
        String downloadURL = await imageUpload.getDownloadURL();
        imageUrls.add(downloadURL);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Failed to add product/image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    await _controller.addProductToFirestore(
      titleController: titleController,
      descriptionController: descriptionController,
      priceController: priceController,
      quantityController: quantityController,
      selectedImages: imageUrls,
      formKey: formKey,
      context: context,
      selectedCategory: _selectedCategory!,
      titleControllerlowercase: titleLowercaseController,
      titleControlleruppercase: titleLowercaseController,
    );

    setState(() {
      isLoading = false;
    });
  }

  void _addSelectedImage(File image) {
    setState(() {
      selectedImages.add(image);
    });
  }

  void _removeSelectedImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
        child: isLoading
            ? const SpinKitDualRing(
                color: primaryBlue,
                size: 32,
              )
            : PrimaryBtn(
                btntxt: 'Add Product',
                onPressedFunction: () {
                  _uploadImagesAndAddProduct();
                },
                width: size.width * 0.15,
              ),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => btmNavBar(initialIndex: 2)));
            },
            isarrowLeading: false,
            title: 'Add Product',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.025),
              const LowOpacityText(text: 'Upload Image'),
              SizedBox(height: size.height * 0.017),
              ImageAdd(
                onImageSelected: _addSelectedImage,
                onImageRemoved: _removeSelectedImage,
                selectedImages: selectedImages,
              ),
              SizedBox(height: size.height * 0.03),
              const LowOpacityText(text: 'Select Category'),
              SizedBox(height: size.height * 0.017),
              Container(
                height: size.height * 0.1,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(1, 4.0),
                      blurRadius: 9.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.007,
                    horizontal: size.width * 0.007,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.85,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: white,
                            elevation: 1,
                            borderRadius: BorderRadius.circular(18),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            value: _selectedCategory,
                            hint: const Text(
                              'Select Product Category',
                              style: TextStyle(fontSize: 12),
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedCategory = newValue;
                                });
                              }
                            },
                            items: _categories.entries
                                .map<DropdownMenuItem<String>>(
                                    (MapEntry<String, String> entry) {
                              return DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(entry.value),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              const LowOpacityText(text: 'Product Info'),
              SizedBox(height: size.height * 0.011),
              ProductInfo(
                formKey: formKey,
                titlecontroller: titleController,
                pricecontroller: priceController,
                quantitycontroller: quantityController,
                title: 'Title.',
                price: 'Total Price.',
                quantity: 'Quantity.',
              ),
              SizedBox(height: size.height * 0.011),
              SizedBox(height: size.height * 0.03),
              const LowOpacityText(text: 'About Product'),
              SizedBox(height: size.height * 0.011),
              Description(
                descriptioncontroller: descriptionController,
                formKey: formKeyDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
