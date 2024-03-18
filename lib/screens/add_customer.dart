import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/add_customer_widgets.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  User? userID = FirebaseAuth.instance.currentUser;
  Future<void> addCustomers() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID?.uid)
          .collection('customers')
          .add({
        'CustomerID': idController.text,
        'CustomerName': nameController.text,
        'CustomerEmail': emailController.text,
        'CustomerContact': contactController.text,
        'CustomerCNIC': cnicController.text,
        'CustomerAddress': addressController.text,
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text('Failed to add Customer $e')));
    }

    idController.clear();
    nameController.clear();
    emailController.clear();
    contactController.clear();
    cnicController.clear();
    addressController.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      content: Text('Customer has been Added!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: PrimaryBtn(
            backgroundColor: white,
            btntxt: 'Add',
            onPressedFunction: () {
              addCustomers();
            },
            width: size.width * 0.02),
      ),
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBarSecondary(
              showMenu: false,
              isarrowLeading: false,
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'Add Customers')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              const CustomGreyText(title: 'Customer Info'),
              AddCustomerInfoCard(
                cIDcontroller: idController,
                customerName: nameController,
                customerEmail: emailController,
                customerContact: contactController,
                customerCNIC: cnicController,
                customerAddress: addressController,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const CustomGreyText(title: 'Granter Info'),
              // const AddGranterInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
