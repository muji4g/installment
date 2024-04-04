import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/categories_listtile.dart';
import 'package:installement1_app/widgets/search_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var searchText = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: AppBarSecondary(
              showLeading: true,
              showMenu: false,
              onPressed: () {
                Navigator.pop(context);
              },
              isarrowLeading: true,
              title: 'Categories'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarCategories(
              hintText: 'Search Products',
              onChanged: (text) {
                setState(() {
                  searchText = text;
                });
              },
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Opacity(
              opacity: 0.4,
              child: Text(
                'Category',
                style: customTextblack.copyWith(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            CategoriesList(
              searchText: searchText,
            )
          ],
        ),
      ),
    );
  }
}
