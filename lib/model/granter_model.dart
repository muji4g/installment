import 'package:flutter/material.dart';

class GranterModel {
  final String name;
  final String email;
  final String contactNum;
  final String nicNum;
  final String address;

  GranterModel(
      {required this.name,
      required this.email,
      required this.contactNum,
      required this.nicNum,
      required this.address});
}

List<GranterModel> granterInfo = [
  GranterModel(
      name: 'JohnWick',
      email: 'johnwick@gmail.com',
      contactNum: '+92 357318581581',
      nicNum: '3106-5713518538-6',
      address: ' Islamabad I-10')
];
