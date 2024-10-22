// views/ticket_history_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/tickets/ticket_history_controller.dart';
import 'package:restaurant_vendor_app/widgets/ticket_history_card.dart';

import '../../controllers/notification/notification_settrings_controller.dart';
import '../notifaicatio/notifaication_view_page.dart';

class TicketHistoryPage extends StatelessWidget {
  final TicketController controller = Get.put(TicketController());
  final NotificationsSettingsController settingsController =
      Get.find<NotificationsSettingsController>();

  TicketHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff7f9fa),
        appBar: AppBar(
          backgroundColor: const Color(0xfff7f9fa),
          title: const Text(
            'Ticket history',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          actions: [
            //add settings page
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                //TODO: Get.to(() => SettingsPage()); sync with the pages
                // Get.to(() => SettingsPage());
              },
            ),
            IconButton(
              icon: const Icon(Icons.notification_add),
              onPressed: () {
                //get.to NotificationView
                Get.to(NotificationView(
                  notificationsList: settingsController.notificationsList,
                ));
              },
            ),
          ],
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.tickets.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TicketItem(ticket: controller.tickets[index]),
                ],
              );
            },
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner_rounded),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
          currentIndex: 0, // Set the current index as per your app flow
          onTap: (index) {},
        ),
      ),
    );
  }
}
