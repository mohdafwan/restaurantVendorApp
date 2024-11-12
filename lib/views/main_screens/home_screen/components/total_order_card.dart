import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';

import '../../../../controllers/pages_controller/home_controller/home_controller.dart';

class OrderSummaryCard extends StatelessWidget {
  final CurrentOrderController controller = Get.find();

  OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Calculate counts based on the latest order list
      int ongoingCount = controller.allOrders
          .where((order) => order.status == 'Ongoing')
          .length;
      int orderReadyCount = controller.allOrders
          .where((order) => order.status == 'Order Ready')
          .length;
      int completedCount = controller.allOrders
          .where((order) => order.status == 'Completed')
          .length;
      int totalOrders = controller.allOrders.length;

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffE5E9EB)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff6434F8).withOpacity(0.15),
              blurRadius: 8.98,
              offset: const Offset(1.5, 2.99),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Operational Date: ${DateFormat('d - MMM - yy').format(DateTime.now())}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              color: Color(0xffE5E9EB),
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusColumn(
                    'Ongoing',
                    ongoingCount,
                  ),
                  _buildStatusColumn(
                    'Order Ready',
                    orderReadyCount,
                  ),
                  _buildStatusColumn(
                    'Completed',
                    completedCount,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xffE5E9EB),
              height: 0,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  'Total Orders: $totalOrders',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper function to build each status column
  Widget _buildStatusColumn(String label, int count) {
    return Column(
      children: [
        Text(
          label,
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          '$count',
          style: TextStyle(
              color: ColorPalette.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ],
    );
  }
}
