import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:installement1_app/controller/productspage_controller.dart';
import 'package:installement1_app/model/productspage_model.dart';
import 'package:installement1_app/screens/dashboard_page.dart';
import 'package:installement1_app/screens/customers_page.dart';
import 'package:installement1_app/screens/payments_page.dart';
import 'package:installement1_app/screens/products_page.dart';
import 'package:installement1_app/screens/settings_page.dart';
import 'package:installement1_app/theme/app_colors.dart';

class btmNavBar extends StatefulWidget {
  final int initialIndex;
  const btmNavBar({super.key, required this.initialIndex});

  @override
  State<btmNavBar> createState() => _btmNavBarState();
}

class _btmNavBarState extends State<btmNavBar> {
  ProductsPageController controller = ProductsPageController();
  ProductsPageModel model = ProductsPageModel();
  @override
  void initState() {
    super.initState();
    controller = ProductsPageController();
    model = ProductsPageModel();
    selectedIndex = widget.initialIndex;
  }

  int selectedIndex = 0;
  void _itemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => screens[index]));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      DashboardScreen(), //sequence matter this will be the index 0
      CustomersScreen(), //and this will be index 1
      //index 2 screen below here
      ProductsPage(controller: controller),

      //index3 screen below
      PaymentsPage(),
      //index4 screen below
      Settingspage(),
    ];
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/homeIcon.svg'),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              'assets/images/homeIcon.svg',
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/usersIcon.svg',
              color: Colors.black.withOpacity(0.5),
            ),
            label: 'customers',
            activeIcon: SvgPicture.asset(
              'assets/images/usersIcon.svg',
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/qrCodeIcon.svg'),
              label: 'Products',
              activeIcon: SvgPicture.asset(
                'assets/images/qrCodeIcon.svg',
                color: Colors.black,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/walletIcon.svg',
                color: Colors.grey,
              ),
              label: 'Payments',
              activeIcon: SvgPicture.asset(
                'assets/images/walletIcon.svg',
                color: Colors.black,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/settingsicon.svg'),
              label: 'Payments',
              activeIcon: SvgPicture.asset(
                'assets/images/settingsicon.svg',
                color: Colors.black,
              )),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        showSelectedLabels: false,
        onTap: _itemTapped,
      ),
    );
  }
}
