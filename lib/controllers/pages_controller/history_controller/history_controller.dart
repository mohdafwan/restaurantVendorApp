import 'package:get/get.dart';

// order_history_controller.dart
import 'package:restaurant_vendor_app/models/OrderHistory/lorder_history_model.dart';

class OrderHistoryController extends GetxController {
  // Observables
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var orderHistory = <Order>[].obs;
  var filteredOrders = <Order>[].obs;

  var searchQuery = ''.obs;
  var selectedStatus = 'Status'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  // Simulate fetching order history data
  void fetchOrderHistory() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2)); // Simulated delay
      var fetchedOrders = Order.getOrderItems(); // Get sample data
      orderHistory.assignAll(fetchedOrders);
      filteredOrders.assignAll(fetchedOrders);
      hasError(false);
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Filter orders based on search query
  void filterOrders(String query) {
    searchQuery(query);
    filteredOrders.assignAll(
      orderHistory
          .where((order) =>
              order.title.toLowerCase().contains(query.toLowerCase()))
          .toList(),
    );
  }

  // Filter orders based on selected status
  void filterByStatus(String status) {
    selectedStatus(status);
    if (status == 'Status') {
      filteredOrders.assignAll(orderHistory);
    } else {
      filteredOrders.assignAll(
        orderHistory.where((order) => order.status == status).toList(),
      );
    }
  }
}
