import 'package:flutter/material.dart';
import 'package:installement1_app/model/productspage_model.dart';

class ProductsPageController {
  late ProductsPageModel model;

  ProductsPageController() {
    model = ProductsPageModel();
  }

  Future<void> checkCategories() async {
    await model.checkCategories();
  }

  void showAddCategoryDialog(BuildContext context) {
    model.showAddCategoryDialog(context);
  }
}
