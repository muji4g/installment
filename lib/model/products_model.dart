import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//Category List Model
class CategoryModel {
  final String categoryType;
  final String categoryImage;
  final bool hasbgColor;

  CategoryModel({
    required this.categoryType,
    required this.categoryImage,
    required this.hasbgColor,
  });
}

List<CategoryModel> categoryList = [
  CategoryModel(
    categoryType: 'Add',
    categoryImage: 'assets/images/addCategory.svg',
    hasbgColor: false,
  ),
  CategoryModel(
    categoryType: 'All',
    categoryImage: 'assets/images/CirclesFour.svg',
    hasbgColor: true,
  ),
  CategoryModel(
    categoryType: 'Mobiles',
    categoryImage: 'assets/images/mobilepicture.svg',
    hasbgColor: false,
  ),
  CategoryModel(
    categoryType: 'Laptop',
    categoryImage: 'assets/images/laptopImage.svg',
    hasbgColor: false,
  ),
  CategoryModel(
    categoryType: 'Electronics',
    categoryImage: 'assets/images/electronicsImage.svg',
    hasbgColor: false,
  ),
];

class ProductModel {
  final String productName;
  final String productPrice;
  final String productStock;
  final Image productImage;
  final Image smallImage;
  final String details;
  final bool inStock;
  ProductModel({
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productImage,
    required this.smallImage,
    required this.inStock,
    required this.details,
  });
}

List<ProductModel> productList = [
  ProductModel(
      productName: 'Iphone 15 128GB',
      productPrice: 'Rs. 2,87000',
      productStock: '12PCS',
      productImage: Image.asset('assets/images/iphoneImage.png'),
      smallImage: Image.asset(
        'assets/images/iphoneImage.png',
        width: 50,
      ),
      inStock: true,
      details:
          'loreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsum'),
  ProductModel(
      productName: 'Iphone 15 128GB',
      productPrice: 'Rs. 2,87000',
      productStock: '12PCS',
      productImage: Image.asset('assets/images/iphoneImage.png'),
      smallImage: Image.asset(
        'assets/images/iphoneImage.png',
        width: 50,
      ),
      inStock: true,
      details:
          'loreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsum'),
  ProductModel(
      productName: 'Iphone 15 128GB',
      productPrice: 'Rs. 2,87000',
      productStock: '12PCS',
      productImage: Image.asset('assets/images/iphoneImage.png'),
      smallImage: Image.asset(
        'assets/images/iphoneImage.png',
        width: 50,
      ),
      inStock: true,
      details:
          'loreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsum'),
  ProductModel(
      productName: 'Iphone 15 128GB',
      productPrice: 'Rs. 2,87',
      productStock: '0PCS',
      productImage: Image.asset('assets/images/iphoneImage.png'),
      smallImage: Image.asset(
        'assets/images/iphoneImage.png',
        height: 90,
        width: 50,
      ),
      inStock: false,
      details:
          'loreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsumloreamIpsum'),
];
