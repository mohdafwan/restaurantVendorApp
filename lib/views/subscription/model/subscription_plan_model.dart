class SubscriptionPlan {
  final String name; // Plan name, e.g., Premium Plan
  final String billingCycle; // Billed Monthly/Yearly
  final List<String> features; // List of features included
  final List<PlanPrice> pricing; // Pricing details for different durations

  SubscriptionPlan({
    required this.name,
    required this.billingCycle,
    required this.features,
    required this.pricing,
  });
}

class PlanPrice {
  final String duration; // Duration type, e.g., 3 Months, 1 Year
  final int price; // Main price
  final int oldPrice; // Old price (optional)

  PlanPrice({
    required this.duration,
    required this.price,
    required this.oldPrice,
  });
}
List<SubscriptionPlan> dummyPlans = [
  SubscriptionPlan(
    name: "Basic Plan",
    billingCycle: "Billed Monthly",
    features: [
      "Access to all basic features",
      "Basic reporting and analytics",
      "Receive real-time alerts on WhatsApp",
    ],
    pricing: [
      PlanPrice(duration: "3 Months", price: 599, oldPrice: 999),
      PlanPrice(duration: "1 Year", price: 1499, oldPrice: 1999),
    ],
  ),
  SubscriptionPlan(
    name: "Advanced Plan",
    billingCycle: "Billed Monthly",
    features: [
      "All Basic Plan features",
      "Advanced reporting and analytics",
      "Priority support",
    ],
    pricing: [
      PlanPrice(duration: "3 Months", price: 999, oldPrice: 1499),
      PlanPrice(duration: "1 Year", price: 2499, oldPrice: 2999),
    ],
  ),
  SubscriptionPlan(
    name: "Premium Plan",
    billingCycle: "Billed Monthly",
    features: [
      "All Advanced Plan features",
      "Premium integrations",
      "Dedicated account manager",
    ],
    pricing: [
      PlanPrice(duration: "3 Months", price: 1999, oldPrice: 2499),
      PlanPrice(duration: "1 Year", price: 4999, oldPrice: 5999),
    ],
  ),
];
