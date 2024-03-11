import 'package:flutter/material.dart';
import 'package:installement1_app/model/categories_model.dart';
import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/model/userdetails_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

class CategoriesList extends StatelessWidget {
  final VoidCallback onPressedFunction;
  const CategoriesList({super.key, required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.7,
      child: ListView.builder(
        itemCount: category.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: size.height * 0.095,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: ListTile(
                leading: Container(
                  child: SizedBox(
                    width: size.width * 0.14,
                    child: category[index].categoryImage,
                  ),
                ),
                title: Text(
                  category[index].categoryName,
                  style: customTextblack.copyWith(
                      fontSize: size.width * 0.032,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  category[index].totalItems.toString() + ' ' + 'items',
                  style: customTextblue.copyWith(fontSize: size.width * 0.032),
                ),
                trailing: SizedBox(
                  width: size.width * 0.34,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: onPressedFunction,
                          child: Text(
                            'Edit',
                            style: customTextblue.copyWith(
                                fontSize: size.width * 0.03),
                          )),
                      TextButton(
                          onPressed: onPressedFunction,
                          child: Text(
                            'Delete',
                            style: customTextred.copyWith(
                                fontSize: size.width * 0.03),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
