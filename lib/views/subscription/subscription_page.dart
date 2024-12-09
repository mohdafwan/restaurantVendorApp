import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_palette.dart';
import '../main_screens/home_screen/components/order_tile.dart';
import 'components/subscriptionPlanCard.dart';
import 'components/top_card.dart';
import 'controller/subscription_controller.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final SubscriptionController controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Subscription Plans")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopCard(),
            Obx(() {
              // Show loading spinner while data is loading
              if (controller.subscriptionPlans.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              // Render the subscription plans in a ListView
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.subscriptionPlans.length,
                itemBuilder: (context, index) {
                  final plan = controller.subscriptionPlans[index];
                  return SubscriptionPlanCard(plan: plan);
                },
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Your previous balance of ₹200 will be updated.",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: const TextSpan(
                    text: "₹599:/",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "₹299",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 44,
                      width: 120,
                      child: CustomButton(
                        onPressed: () {
                          // Handle continue button
                        },
                        backgroundColor: ColorPalette.primaryColor,
                        textColor: Colors.white,
                        fontSize: 14,
                        height: 44,
                        borderRadius: 10,
                        text: 'Continue',
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        // Handle close action
                      },
                      icon: const Icon(Icons.close, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
