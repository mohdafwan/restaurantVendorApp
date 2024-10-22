import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import '../../widgets/alert_dialog.dart';
import 'components/setting_group.dart';
import 'components/setting_tile.dart';

class SettingsPagex extends StatelessWidget {
  const SettingsPagex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsGroup(
              settingsGroupTitle: 'Account',
              items: [
                SettingTile(
                  title: 'Profile',
                  icon: Icons.person_outline_rounded,
                  onTap: () {
                    Get.find<DashboardController>().changeTabIndex(3);
                  },
                ),
                SettingTile(
                  title: 'Password',
                  icon: Icons.lock_outline_rounded,
                  onTap: () {
                    Get.toNamed('/onsettingpasswordreset');
                  },
                ),
                SettingTile(
                  title: 'Notification',
                  icon: Icons.notifications_none_rounded,
                  onTap: () {
                    Get.toNamed("/onsettingnotification");
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SettingsGroup(
              settingsGroupTitle: 'More',
              items: [
                SettingTile(
                  title: 'Rate & Review',
                  icon: Icons.star_border_rounded,
                  onTap: () {
                    Get.toNamed('/onsettingrate&review');
                  },
                ),
                SettingTile(
                  title: 'Help',
                  icon: Icons.help_outline_rounded,
                  onTap: () {
                    Get.toNamed('/onsettinghelp');
                  },
                ),
                SettingTile(
                  title: 'Raise Ticket',
                  icon: Icons.airplane_ticket_outlined,
                  onTap: () {
                    Get.find<DashboardController>().changeTabIndex(5);
                  },
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  showCustomAlertDialog(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(0).copyWith(bottom: 10),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// To show the dialog
void showCustomAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReusableAlertDialog(
        title: 'Logout',
        icon: Icons.logout,
        subtitle: 'Are you sure you want to log out?',
        onYesPressed: () {
          // Handle Yes button action
          Get.find<AuthMethods>().signOut();
        },
        onNoPressed: () {
          // Handle No button action
          Navigator.of(context).pop();
        },
        yesButtonText: 'Yes',
        noButtonText: 'No',
        backgroundColor:
            Colors.orange[200], // Custom background color if needed
      );
    },
  );
}
