import 'package:flutter/material.dart';

import '../model/subscription_plan_model.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;

  const SubscriptionPlanCard({required this.plan, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.name,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(plan.billingCycle),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: plan.features
                  .map((feature) => Text("- $feature"))
                  .toList(),
            ),
            const SizedBox(height: 8),
            const Text(
              "Pricing:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: plan.pricing.map((price) {
                return Text(
                  "${price.duration}: ₹${price.price} (Old Price: ₹${price.oldPrice})",
                  style: const TextStyle(color: Colors.green),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
