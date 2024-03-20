import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/screens/product_details.dart';

import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/FormFields.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:installement1_app/widgets/large_strings.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryList();
}

class _CategoryList extends State<CategoryList> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.096,
      child: ListView.builder(
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: InkWell(
                    onTap: () {
                      if (categoryList[index].categoryType == 'Add') {
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          barrierColor: primaryBlue.withOpacity(0.3),
                          builder: (context) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.03,
                                    horizontal: size.width * 0.1),
                                child: SingleChildScrollView(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Add Category',
                                        style: customTextblack.copyWith(
                                            fontSize: size.width * 0.04,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        width: size.width * 0.8,
                                        height: size.height * 0.25,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.image,
                                                size: size.width * 0.1,
                                                color: Color(0xffC2C2C2),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Upload Image',
                                                  style:
                                                      customTextgrey.copyWith(
                                                          fontSize: size.width *
                                                              0.03),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.015,
                                      ),
                                      TextFieldBottomSheet(
                                        resetPassController: controller,
                                        hinttxt: 'Category Name',
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      BottomSheetButton(
                                          btntxt: 'Add',
                                          onPressed: () {},
                                          width: size.width * 0.7,
                                          height: size.height * 0.05)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    splashColor: primaryBlue,
                    borderRadius: BorderRadius.circular(55),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: categoryList[index].hasbgColor
                              ? lineargradient
                              : null),
                      child: CircleAvatar(
                        backgroundColor: categoryList[index].hasbgColor
                            ? Colors.transparent
                            : Colors.white,
                        radius: 25,
                        child: SvgPicture.asset(
                          categoryList[index].categoryImage,
                          width: categoryList[index].hasbgColor
                              ? size.width * 0.07
                              : size.width * 0.17,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(categoryList[index].categoryType),
              ],
            );
          }),
    );
  }
}

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.88,
              mainAxisSpacing: size.height * 0.01,
              crossAxisSpacing: size.width * 0.017),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32)),
                      // height: size.height * 0.18,
                      // width: size.width * 0.5,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails()));
                            },
                            child: Image.asset(
                              'assets/images/iphoneImage.png',
                            ),
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          Text(
                            productList[index].productName,
                            style: customTextblack.copyWith(
                                fontSize: size.width * 0.030,
                                fontWeight: FontWeight.w600),
                          ),
                          Text('(' + productList[index].productStock + ')',
                              style: productList[index].inStock
                                  ? customTextgreen.copyWith(
                                      fontSize: size.width * 0.030,
                                      fontWeight: FontWeight.w600)
                                  : customTextred.copyWith(
                                      fontSize: size.width * 0.030,
                                      fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.2),
                      child: Text(productList[index].productPrice,
                          style: customTextgreen.copyWith(
                              fontSize: size.width * 0.030,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
