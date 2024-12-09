import 'package:get/get.dart';

import '../model/subscription_plan_model.dart';

class SubscriptionController extends GetxController {
  var isLoading = true.obs;

  var subscriptionPlans = <SubscriptionPlan>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPlans();
  }

  void fetchSubscriptionPlans() async {
    try {
      isLoading(true);
      // Simulate API call (Replace this with actual API call logic)
      await Future.delayed(const Duration(seconds: 2));
      subscriptionPlans.value = dummyPlans;
    } catch (e) {
      print("Error fetching plans: $e");
    } finally {
      isLoading(false);
    }
  }
}
