import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/views/Chat&Ticket/ChatPage/ChatPage.dart';
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
            switch(controller.currentTab){
              case 1:
              case 2:
              controller.tabIndex.value = 0;
              break;

              case 3:
              controller.tabIndex.value = 2;
              break;

              case 4:
              controller.tabIndex.value = 3;
              break;

              case 5:
              controller.tabIndex.value = 2;
            }
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
              ChatPage(),
            ],
          ),
          bottomNavigationBar: const BottomNavBar(),
        ),
      );
    });
  }
}
