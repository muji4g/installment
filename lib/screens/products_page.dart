// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installement1_app/controller/productspage_controller.dart';
import 'package:installement1_app/screens/add_product.dart';
import 'package:installement1_app/screens/categories_screen.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar.dart';
import 'package:installement1_app/widgets/products_listTile.dart';
import 'package:installement1_app/widgets/search_bar.dart';

class ProductsPage extends StatefulWidget {
  final ProductsPageController controller;

  const ProductsPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late bool _categoriesLoaded;
  late bool _showAddProduct;
  late String _selectedCategory;
  var searchText = '';

  @override
  void initState() {
    super.initState();
    _categoriesLoaded = false;
    _showAddProduct = false;
    _selectedCategory = '';
    widget.controller.checkCategories().then((_) {
      setState(() {
        _showAddProduct = widget.controller.model.showAddProduct;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
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
                  MaterialPageRoute(builder: (context) => AddProductScreen()),
                );
              } else {
                widget.controller.showAddCategoryDialog(context);
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.051),
        child: Column(
          children: [
            SearchBarProducts(
              hintText: 'Search Products',
              onChanged: (text) {
                setState(() {
                  searchText = text;
                });
              },
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
                          builder: (context) => const CategoriesScreen(),
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
            if (!_showAddProduct && _categoriesLoaded)
              const Padding(
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
            if (_showAddProduct)
              FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for the future to complete
                    return Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: const Center(
                        child: SpinKitDualRing(
                          lineWidth: 2,
                          color: primaryBlue,
                          size: 35,
                        ),
                      ),
                    );
                  } else {
                    // Future completed, show the product grid
                    return ProductGrid(
                      selectedCategory: _selectedCategory,
                      searchText: searchText,
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
