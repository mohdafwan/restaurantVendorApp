import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/homePage.dart';
import 'package:restaurant_vendor_app/widgets/BottomNavBar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            body: IndexedStack(
              index: controller.tabIndex.value,
              children: [
                const HomeScreen(),
                OrderHistoryView(),
                const SettingsPagex(),
                const EditProfilePage(),
                OrderHistoryView(),
                const SubmitIssuePage(),
              ],
            ),
            bottomNavigationBar: CustomBottomNavBar(
              selectedIndex: controller.tabIndex.value,
              onItemTapped: controller.changeTabIndex,
            ),
          );
        });
=======
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: const [
            HomePage(),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(), // uncomment order and profile onTap when they are created in navBar
      );
    });
>>>>>>> cd0888ae30d5bb9adcbff8225f7e6c30c0efa4a4
  }
}
