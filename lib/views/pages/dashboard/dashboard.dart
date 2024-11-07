import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/homePage.dart';
import 'package:restaurant_vendor_app/widgets/BottomNavBar.dart';

import '../../main_screens/home_screen/home_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: const [
            HomePage(),
            HomeScreen(),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(), // uncomment order and profile onTap when they are created in navBar
      );
    });
  }
}
