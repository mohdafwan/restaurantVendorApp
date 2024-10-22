import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/views/EditProfileView/EditProfilePage.dart';
import 'package:restaurant_vendor_app/views/main_screens/history_screen/history_screen.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/home_screen.dart';
import 'package:restaurant_vendor_app/views/setting/setting_page.dart';
import 'package:restaurant_vendor_app/views/tickets/raise_ticket.dart';
import 'package:restaurant_vendor_app/widgets/custom_bottomNavbar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
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
  }
}
