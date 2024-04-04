import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductsPageModel {
  late bool categoriesLoaded;
  late bool showAddProduct;
  late String selectedCategory;

  Future<void> checkCategories() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot categoriesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('categories')
          .get();
      categoriesLoaded = true;
      showAddProduct =
          categoriesSnapshot.docs.isNotEmpty; // Update _showAddProduct
    }
  }

  void showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Categories Found'),
          content: Text('Please add a category first to add products.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Add Category'),
            ),
          ],
        );
      },
    );
  }
}
