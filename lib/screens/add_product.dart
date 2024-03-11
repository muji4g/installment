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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            children: [ImageAdd()],
          ),
        ));
  }
}
