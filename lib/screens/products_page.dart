import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:installement1_app/screens/add_product.dart';
import 'package:installement1_app/screens/categories_screen.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar.dart';
import 'package:installement1_app/widgets/products_listTile.dart';
import 'package:installement1_app/widgets/search_bar.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _categoriesLoaded = false;
  bool _showAddProduct = false;
  String _selectedCategory = '';
  var searchText = '';

  @override
  void initState() {
    super.initState();
    _checkCategories(); // Check if categories exist for the user
  }

  void _checkCategories() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot categoriesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('categories')
          .get();
      setState(() {
        _categoriesLoaded = true;
        _showAddProduct = categoriesSnapshot.docs.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: Padding(
          padding: EdgeInsets.only(
            top: size.width * 0.011,
            left: 12,
            right: 12,
          ),
          child: appBar(
            title: 'Products',
            addIcon: true,
            onPressedFunction: () {
              if (_showAddProduct) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
              } else {
                _showAddCategoryDialog(context);
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.051),
        child: Column(
          children: [
            AppSearchBar(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              hintText: 'Search Products',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 0.4,
                    child: Text(
                      'Category',
                      style: customTextblack.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: customTextblue.copyWith(
                        fontSize: size.width * 0.038,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        color: primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CategoryList(
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
            if (!_showAddProduct &&
                _categoriesLoaded) // Show message if no categories and categories are loaded
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Please add a category first',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.63,
                bottom: 4,
              ),
              child: Opacity(
                opacity: 0.4,
                child: Text(
                  'Products',
                  style: customTextblack.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (_showAddProduct) // Show product grid if categories exist
              ProductGrid(
                  selectedCategory: _selectedCategory, searchText: searchText),
          ],
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
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
