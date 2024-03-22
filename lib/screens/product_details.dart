import 'package:flutter/material.dart';

import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/product_details_widgets.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBarSecondary(
            showLeading: true,
            showMenu: true,
            isarrowLeading: true,
            onPressed: () {
              Navigator.pop(context);
            },
            title: 'Product Details'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              width: size.width * 1.2,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  child: Image.asset('assets/images/product_Image.png')),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06, vertical: size.height * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        productList[0].productName,
                        style: customTextgrey.copyWith(
                            fontSize: size.width * 0.044),
                      ),
                      Text(
                        '(' + productList[2].productStock + ')',
                        style: customTextgreen.copyWith(
                            fontSize: size.width * 0.03),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.6),
                    child: Text(
                      textAlign: TextAlign.start,
                      productList[1].productPrice,
                      style:
                          customTextblue.copyWith(fontSize: size.width * 0.05),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.624),
                    child: const CustomGreyText(title: 'Installment Plan'),
                  ),
                  const InstallmentPlanSection(),
                  Padding(
                    padding: EdgeInsets.only(
                        right: size.width * 0.624, top: size.height * 0.011),
                    child: const CustomGreyText(title: 'About Product'),
                  ),
                  AboutProduct(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
