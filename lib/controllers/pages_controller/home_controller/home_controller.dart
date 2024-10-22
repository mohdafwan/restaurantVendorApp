import 'package:get/get.dart';

import 'package:restaurant_vendor_app/models/home/corrent_order_ststus_model.dart';

class CurrentOrderController extends GetxController {
  var isLoading = true.obs; // Loading state
  var hasError = false.obs; // Error state
  var errorMessage = ''.obs; // Error message
  var currentOrder = <CurrentOrderStatusModel>[].obs; //

  @override
  void onInit() {
    super.onInit();
    fetchCurrentOrderItem();
  }

  Future<void> fetchCurrentOrderItem() async {
    try {
      isLoading(true);
      await Future.delayed(Duration(seconds: 2));
      var currentOrders = CurrentOrderStatusModel.currentOrderItem();
      currentOrder.assignAll(currentOrders);
      hasError(false);
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false); // Stop loading in all cases
    }
  }
}
