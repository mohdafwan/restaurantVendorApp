import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_palette.dart';
import '../controller/subscription_controller.dart';
import '../model/subscription_plan_model.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;

  const SubscriptionPlanCard({required this.plan, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();
    return Obx(() {
      bool isSelectedPlan = controller.selectedPlan.value?.name == plan.name;

      return Card(
        color:
            isSelectedPlan ? const Color(0xff202842) : const Color(0xffF7F9FA),
        shadowColor: ColorPalette.borderColor.withOpacity(0.2),
        surfaceTintColor: ColorPalette.backgroundColor,
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //add a circlr and icon in cernter and color,
              CircleAvatar(
                backgroundColor: isSelectedPlan
                    ? const Color(0xffFFFFFF)
                    : ColorPalette.primaryColor.withOpacity(0.1),
                radius: 20,
                child: const Icon(
                  Icons.star_border_rounded,
                  color: ColorPalette.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                plan.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isSelectedPlan
                      ? const Color(0xffFFFFFF)
                      : const Color(0xFF010104),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                plan.billingCycle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isSelectedPlan
                      ? const Color(0xFFDEDEDE)
                      : const Color(0xFF667085),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: plan.features
                    .map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: ColorPalette.white,
                              radius: 14,
                              child: Icon(
                                Icons.check,
                                weight: 30,
                                opticalSize: 40,
                                color: ColorPalette.statusText,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  color: isSelectedPlan
                                      ? const Color(0xFFDEDEDE)
                                      : const Color(0xFF667085),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: plan.pricing.map((price) {
                  bool isSelectedPrice = isSelectedPlan &&
                      controller.selectedPrice.value?.duration ==
                          price.duration;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.selectPlan(plan, price);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelectedPrice
                              ? ColorPalette.white
                              : Colors.transparent,
                          border: Border.all(
                            color: const Color(0xffEAECF0),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  price.duration,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isSelectedPrice
                                        ? const Color(0xff1E1E1E)
                                        : isSelectedPlan
                                            ? Colors.white
                                            : const Color(0xff1E1E1E),
                                  ),
                                ),
                                //add a circle and icon in center and color
                                // Add a circle and icon in the center with color
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelectedPrice
                                        ? ColorPalette.primaryColor
                                        : Colors.white,
                                    border: Border.all(
                                      color: isSelectedPrice
                                          ? Colors.transparent
                                          : const Color(0xffEAECF0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 8,
                                    child: isSelectedPrice
                                        ? const Icon(Icons.check,
                                            color: Colors.white, size: 10)
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                text: '₹${price.price}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: isSelectedPrice
                                      ? const Color(0xff1E1E1E)
                                      : isSelectedPlan
                                          ? Colors.white
                                          : const Color(0xff1E1E1E),
                                ),
                                children: [
                                  TextSpan(
                                    text: "/",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isSelectedPrice
                                          ? const Color(0xff1E1E1E)
                                          : isSelectedPlan
                                              ? Colors.white
                                              : const Color(0xff1E1E1E),
                                    ),
                                  ),
                                  TextSpan(
                                    text: price.oldPrice.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isSelectedPrice
                                          ? const Color(0xff1E1E1E)
                                          : isSelectedPlan
                                              ? Colors.white
                                              : const Color(0xff1E1E1E),
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    });
  }
}
