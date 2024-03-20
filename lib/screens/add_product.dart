import 'package:flutter/material.dart';

import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/add_products_widgets.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                const ImageAdd(),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const LowOpacityText(text: 'Product Info'),
                SizedBox(
                  height: size.height * 0.011,
                ),
                const ProductInfo(
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
                const Description(),
              ],
            ),
          ),
        ));
  }
}
