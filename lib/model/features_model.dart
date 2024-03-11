import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class Recentfeatures {
  final String title;
  final String value;
  final String subtitle;
  final String subText;
  SvgPicture picture;
  Recentfeatures(
      {required this.title,
      required this.value,
      required this.subtitle,
      required this.subText,
      required this.picture});
}

List<Recentfeatures> features = [
  Recentfeatures(
    title: 'Catalouge',
    value: '500',
    subtitle: 'All items',
    subText: 'items',
    picture: SvgPicture.asset(
      'assets/images/catalouge_icon.svg',
    ),
  ),
  Recentfeatures(
    title: 'Payments',
    value: '\$5000',
    subtitle: 'Pending Payments',
    subText: 'Pending',
    picture: SvgPicture.asset(
      'assets/images/walletIcon.svg',
    ),
  ),
  Recentfeatures(
    title: 'My Customers',
    value: '500',
    subtitle: 'Customers',
    subText: 'Total',
    picture: SvgPicture.asset(
      'assets/images/customerIcon.svg',
    ),
  ),
];
