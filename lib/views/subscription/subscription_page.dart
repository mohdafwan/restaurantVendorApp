import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.backgroundColor,
        foregroundColor: ColorPalette.backgroundColor,
        surfaceTintColor: ColorPalette.backgroundColor,
        title: const Text(
          "Subscription Plans",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: ColorPalette.textColor,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
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
      bottomNavigationBar: Obx(() {
        final controller = Get.find<SubscriptionController>();
        return Visibility(
          visible: controller.selectedPlan.value != null &&
              controller.selectedPrice.value != null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.selectedPlan.value != null &&
                    controller.selectedPrice.value != null)
                  Text(
                    "Selected: ${controller.selectedPlan.value!.name}, ₹${controller.selectedPrice.value!.price}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (controller.selectedPrice.value != null)
                      RichText(
                        text: TextSpan(
                          text: "₹${controller.selectedPrice.value!.price}/",
                          style: const TextStyle(
                            color: Color(0xff1E1E1E),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "₹${controller.selectedPrice.value!.oldPrice}",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
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
                              controller.selectedPlan.value == null ||
                                      controller.selectedPrice.value == null
                                  ? null
                                  : print(
                                      "OK: ${controller.selectedPlan.value!.name}, ₹${controller.selectedPrice.value!.price}");
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
                            // Clear the selected values when the icon is pressed
                            controller.selectedPlan.value = null;
                            controller.selectedPrice.value = null;
                          },
                          splashRadius: 20,
                          icon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette.primaryColor.withOpacity(0.1),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.close,
                              color: Color(0xff445275),
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
