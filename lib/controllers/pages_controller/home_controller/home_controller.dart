import 'package:get/get.dart';
import 'package:restaurant_vendor_app/models/home/corrent_order_ststus_model.dart';

class CurrentOrderController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  var orderList = <OrderModel>[].obs;
  var allOrders = <OrderModel>[].obs;

  // Filter state
  var isFilterVisible = false.obs;
  var selectedOrderTypes = <String>[].obs;
  var selectedStatus = <String>[].obs;
  var selectedDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() async {
    try {
      isLoading(true);
      isError(false);
      await Future.delayed(const Duration(seconds: 2));
      var fetchedOrders = [
        OrderModel(
          orderId: '#12345',
          orderNumber: '#85768',
          status: 'Ongoing',
          totalAmount: '₹100',
          orderType: 'Food',
          userId: '#5234',
          userName: 'Biswa',
          date: 'Aug 13, 2024',
          time: '1:34 PM',
          phoneNumber: '+91 91999919119',
        ),
        OrderModel(
          orderId: '#12346',
          orderNumber: '#85769',
          status: 'Order Ready',
          totalAmount: '₹200',
          orderType: 'Drink',
          userId: '#5234',
          userName: 'John',
          date: 'Aug 14, 2024',
          time: '2:34 PM',
          phoneNumber: '+91 91999919220',
        ),
        OrderModel(
          orderId: '#12347',
          orderNumber: '#85770',
          status: 'Order Ready',
          totalAmount: '₹300',
          orderType: 'Snack',
          userId: '#5234',
          userName: 'Sarah',
          date: 'Aug 15, 2024',
          time: '3:34 PM',
          phoneNumber: '+91 91999919330',
        ),
        OrderModel(
          orderId: '#12348',
          orderNumber: '#85771',
          status: 'Ongoing',
          totalAmount: '₹150',
          orderType: 'Food',
          userId: '#5234',
          userName: 'Chris',
          date: 'Aug 16, 2024',
          time: '4:34 PM',
          phoneNumber: null,
        ),
        OrderModel(
          orderId: '#12349',
          orderNumber: '#85772',
          status: 'Order Ready',
          totalAmount: '₹250',
          orderType: 'Drink',
          userId: '#5234',
          userName: 'Alex',
          date: 'Aug 17, 2024',
          time: '5:34 PM',
          phoneNumber: '+91 91999919550',
        ),
        OrderModel(
          orderId: '#12345',
          orderNumber: '#85772',
          status: 'Completed',
          totalAmount: '₹599',
          orderType: 'Food',
          userId: '#1903',
          userName: 'Iva Ryan',
          date: 'Aug 13, 2024',
          time: '1:34 PM',
          phoneNumber: '+91 91999919550',
        ),
      ];

      orderList.value = fetchedOrders;
      allOrders.value = fetchedOrders; // Keep a copy for search filtering
    } catch (e) {
      isError(true);
    } finally {
      isLoading(false);
    }
  }

// Toggle filter visibility
  void toggleFilterVisibility() {
    isFilterVisible.value = !isFilterVisible.value;
  }

  // Add or remove selected filters
  void toggleStatusFilter(String status) {
    if (selectedStatus.contains(status)) {
      selectedStatus.remove(status);
    } else {
      selectedStatus.add(status);
    }
  }

  void toggleOrderTypeFilter(String orderType) {
    if (selectedOrderTypes.contains(orderType)) {
      selectedOrderTypes.remove(orderType);
    } else {
      selectedOrderTypes.add(orderType);
    }
  }

  // Set or reset selected date
  void setDateFilter(String date) {
    selectedDate.value = date;
  }

  void applyFilters() {
    orderList.assignAll(allOrders.where((order) {
      bool matchesStatus =
          selectedStatus.isEmpty || selectedStatus.contains(order.status);
      bool matchesType = selectedOrderTypes.isEmpty ||
          selectedOrderTypes.contains(order.orderType);
      bool matchesDate =
          selectedDate.value.isEmpty || selectedDate.value == order.date;
      return matchesStatus && matchesType && matchesDate;
    }).toList());
  }

  // Clear filters
  void clearFilters() {
    selectedStatus.clear();
    selectedOrderTypes.clear();
    selectedDate.value = '';
    applyFilters();
  }

  // Search filter method
  void filterOrders(String query) {
    if (query.isEmpty) {
      orderList.value = allOrders;
    } else {
      orderList.value = allOrders
          .where((order) =>
              order.userName.toLowerCase().contains(query.toLowerCase()) ||
              order.orderId.contains(query) ||
              order.orderNumber.contains(query))
          .toList();
    }
  }
}
