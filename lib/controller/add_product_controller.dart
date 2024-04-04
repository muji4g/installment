import 'dart:io';
import 'package:flutter/material.dart';

import 'package:installement1_app/model/addproduct_model.dart';
import 'package:installement1_app/screens/installmentpage_section.dart';

class AddProducts {
  final List<String> images;
  final String productName;
  final String description;
  final String productPrice;
  final String quantity;
  final String producttitleUpperCase;
  final String producttitlelowerCase;
  // final String selectedCategory;
// ,required this.category,
  AddProducts({
    required this.images,
    required this.producttitleUpperCase,
    required this.producttitlelowerCase,
    required this.productName,
    required this.description,
    required this.productPrice,
    required this.quantity,
  });
}
// required this.selectedCategory

class AddProductController {
  final AddProductModel model;

  AddProductController(this.model);

  Future<Map<String, String>> fetchCategories() async {
    try {
      return await model.fetchCategories();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addProductToFirestore({
    required TextEditingController titleController,
    required TextEditingController titleControllerlowercase,
    required TextEditingController titleControlleruppercase,
    required TextEditingController priceController,
    required TextEditingController quantityController,
    required TextEditingController descriptionController,
    required List<String> selectedImages,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required String selectedCategory,
  }) async {
    if (formKey.currentState!.validate()) {
      if (selectedImages.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one image.'),
            backgroundColor: Colors.red,
          ),
        );
        return '';
      }

      try {
        final product = AddProducts(
          images: selectedImages,
          productName: titleController.text,
          description: descriptionController.text,
          productPrice: priceController.text,
          quantity: quantityController.text,
          producttitleUpperCase: titleControlleruppercase.text,
          producttitlelowerCase: titleControllerlowercase.text,
        );

        final productId = await model.addProductToFirestore(
            product, selectedImages, selectedCategory);

        // Navigate to InstallmentPlan screen with the generated product ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InstallmentPlan(productId: productId),
          ),
        );

        // Show a snackbar indicating success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Product added'),
            backgroundColor: Colors.green,
          ),
        );
        return productId;
      } catch (e) {
        print('Error adding product: $e');
        // Show a snackbar indicating failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Failed to add product'),
            backgroundColor: Colors.red,
          ),
        );
        rethrow;
      }
    }
    return '';
  }

  void addSelectedImage({
    required File image,
    required List<File> selectedImages,
    required Function(List<File>) updateImages,
  }) {
    updateImages([...selectedImages, image]);
  }

  void removeSelectedImage({
    required int index,
    required List<File> selectedImages,
    required Function(List<File>) updateImages,
  }) {
    selectedImages.removeAt(index);
    updateImages([...selectedImages]);
  }
}


//  Future<String> addProductToFirestore({
//     required TextEditingController titleController,
//     required TextEditingController priceController,
//     required TextEditingController quantityController,
//     required TextEditingController descriptionController,
//     required List<File> selectedImages,
//     required GlobalKey<FormState> formKey,
//     required BuildContext context,
//   }) async {
//     if (formKey.currentState!.validate()) {
//       try {
//         final product = AddProducts(
//           productName: titleController.text,
//           productPrice: priceController.text,
//           quantity: quantityController.text,
//           description: descriptionController.text,
//         );

//         final productId = await model.addProductToFirestore(product);

//         // Navigate to InstallmentPlan screen with the generated product ID
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => InstallmentPlan(productId: productId),
//           ),
//         );

//         // Show a snackbar indicating success
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             behavior: SnackBarBehavior.floating,
//             content: Text('Product added'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         return productId;
//       } catch (e) {
//         print('Error adding product: $e');
//         // Show a snackbar indicating failure
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             behavior: SnackBarBehavior.floating,
//             content: Text('Failed to add product'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         rethrow;
//       }
//     }
//     return '';
//   }