import 'package:flutter/material.dart';

class Category {
  final String categoryName;
  final double totalItems;
  final Image categoryImage;
  Category(
      {required this.categoryImage,
      required this.categoryName,
      required this.totalItems});
}

List<Category> category = [
  Category(
      categoryImage: Image.asset('assets/images/mobile_Category.png'),
      categoryName: 'Mobiles',
      totalItems: 100),
  Category(
      categoryImage: Image.asset('assets/images/laptopImage.png'),
      categoryName: 'Laptops',
      totalItems: 100),
  Category(
      categoryImage: Image.asset('assets/images/electronics_category.png'),
      categoryName: 'Electronics',
      totalItems: 100),
];
