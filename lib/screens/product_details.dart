// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installement1_app/model/product_details_model.dart';

import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/screens/installmentpage_section.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/product_details_widgets.dart';

class ProductDetails extends StatefulWidget {
  final String documentId;
  const ProductDetails({super.key, required this.documentId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ProductService _productService = ProductService();
  late Future<DocumentSnapshot<Map<String, dynamic>>> _productDetailsFuture;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productDetailsFuture =
        _productService.getProductDetails(user!.uid, widget.documentId);
  }

  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBarSecondary(
            documentId: widget.documentId,
            showLeading: true,
            showMenu: true,
            isarrowLeading: true,
            onPressed: () {
              Navigator.pop(context);
            },
            title: 'Product Details'),
      ),
      body: FutureBuilder(
        future: _productDetailsFuture,
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitDualRing(
              color: primaryBlue,
              size: 32,
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Failed With Error : ${snapshot.error}',
              style: customTextred.copyWith(fontSize: size.width * 32),
            ));
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              Map<String, dynamic>? productData = snapshot.data!.data()!;
              // Map<String, dynamic> productData = snapshot.data!
              // .data()!; //I have also tried this but does not work!

              List<dynamic> imageUrls = productData['images'];
              print('Null check');
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width * 1.2,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          child: Image.network(
                            imageUrls[0],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                          vertical: size.height * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                productData['title'],
                                style: customTextgrey.copyWith(
                                    fontSize: size.width * 0.044),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Text(
                                productData['quantity'],
                                style: customTextgreen.copyWith(
                                    fontSize: size.width * 0.04,
                                    color: productData['quantity'] == '0'
                                        ? Colors.red
                                        : secondaryGreen),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.3),
                            child: Text(
                              'Starting From Rs.' + productData['price'],
                              style: customTextblue.copyWith(
                                  fontSize: size.width * 0.045),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.624),
                            child:
                                const CustomGreyText(title: 'Installment Plan'),
                          ),
                          InstallmentPlanSection(
                            documentId: widget.documentId,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: size.width * 0.624,
                                top: size.height * 0.011),
                            child: const CustomGreyText(title: 'About Product'),
                          ),
                          AboutProduct(
                            userId: user!.uid,
                            productId: widget.documentId,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    Text(
                      'No Installments Found!!',
                      style:
                          customTextblack.copyWith(fontSize: size.width * 0.05),
                    ),
                    PrimaryBtn(
                        btntxt: 'Add Installment',
                        onPressedFunction: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InstallmentPlan(
                                        productId: widget.documentId,
                                      )));
                        },
                        width: size.width * 0.1)
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
