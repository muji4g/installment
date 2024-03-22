import 'dart:io';

import 'package:flutter/material.dart';
import 'package:installement1_app/screens/add_product.dart';
import 'package:installement1_app/screens/categories_screen.dart';

import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

import 'package:installement1_app/widgets/appBar.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/products_listTile.dart';
import 'package:installement1_app/widgets/search_bar.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bgColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.011, left: 12, right: 12),
                child: appBar(
                    title: 'Products',
                    addIcon: true,
                    onPressedFunction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProduct()));
                    }))),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.051),
          child: Column(
            children: [
              const AppSearchBar(
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
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoriesScreen()));
                        },
                        child: Text(
                          'See All',
                          style: customTextblue.copyWith(
                              fontSize: size.width * 0.038,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              color: primaryBlue),
                        )),
                  ],
                ),
              ),
              CategoryList(),
              Padding(
                padding: EdgeInsets.only(right: size.width * 0.63, bottom: 4),
                child: Opacity(
                  opacity: 0.4,
                  child: Text(
                    'Products',
                    style: customTextblack.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ProductGrid(),
            ],
          ),
        ));
  }
}
