import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/screens/edit_customer.dart';
import 'package:installement1_app/screens/edit_products.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/large_strings.dart';

class AppBarSecondary extends StatefulWidget {
  final String? documentId;
  final String title;

  final bool isarrowLeading;
  final bool showMenu;
  final bool showLeading;
  final VoidCallback onPressed;
  const AppBarSecondary({
    super.key,
    required this.showMenu,
    required this.isarrowLeading,
    required this.onPressed,
    required this.title,
    required this.showLeading,
    this.documentId,
  });

  @override
  State<AppBarSecondary> createState() => _AppBarSecondaryState();
}

User? user = FirebaseAuth.instance.currentUser;

class _AppBarSecondaryState extends State<AppBarSecondary> {
  Future<void> deleteProduct() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('products')
          .doc(widget.documentId)
          .delete();
      // Show success message or navigate back
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 58, 179, 2),
        behavior: SnackBarBehavior.floating,
        content: Text('Product deleted successfully'),
      ));
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Text('Failed To delete error with code $e'),
      ));
    }
  }

  get async => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: widget.showLeading,
      elevation: 0.0,
      backgroundColor: bgColor,
      title: Text(
        widget.title,
        style: customTextblack.copyWith(
            fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: widget.showLeading
          ? widget.isarrowLeading
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onPressed,
                )
              : IconButton(
                  icon: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.x,
                      size: 16,
                    ),
                    onPressed: widget.onPressed,
                  ),
                  onPressed: widget.onPressed,
                )
          : null,
      actions: widget.showMenu
          ? [
              Padding(
                padding: EdgeInsets.only(right: size.width * 0.03),
                child: PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                  onSelected: (value) async {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProductPage(),
                        ),
                      );
                    } else if (value == 'delete') {
                      // Show a dialog box for confirmation
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Deletion"),
                            content: const Text(
                                "Are you sure you want to delete this product?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: const Text("Delete"),
                                onPressed: () async {
                                  // Call the function to delete the product
                                  await deleteProduct();
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Image.asset(
                    'assets/images/DotsThreeVertical.png',
                    width: size.width * 0.083,
                  ),
                ),
              )
            ]
          : null,
    );
  }
}
