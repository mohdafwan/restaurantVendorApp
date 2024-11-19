import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/views/EditProfileView/EditProfilePage.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/homePage.dart';
import 'package:restaurant_vendor_app/views/settings/help&settings.dart';
import 'package:restaurant_vendor_app/views/settings/settings_page.dart';
import 'package:restaurant_vendor_app/widgets/BottomNavBar.dart';

import '../../main_screens/home_screen/home_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DashboardController>()) {
      Get.put(DashboardController());
    }
    return GetBuilder<DashboardController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          if (controller.tabIndex.value > 0) {
            controller.tabIndex.value -= controller.tabIndex.value == 2 ? 2:1;
            controller.update();
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: controller.tabIndex.value,
            children: const [
              HomePage(),
              HomeScreen(),
              SettingsPage(),
              HelpAndSettings(),
              EditProfilePage(),
            ],
          ),
          bottomNavigationBar: const BottomNavBar(),
        ),
      );
    });
  }
}
