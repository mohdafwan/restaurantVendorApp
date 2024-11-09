// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:restaurant_vendor_app/models/home/corrent_order_ststus_model.dart';

// class CurrentOrderController extends GetxController {
//   var isLoading = true.obs;
//   var isError = false.obs;
//   var orderList = <OrderModel>[].obs;
//   var allOrders = <OrderModel>[].obs;

//   var dateLabel = ''.obs; // Label to display formatted date
//   var dateRange = DateTimeRange(
//     start: DateTime.now(),
//     end: DateTime.now(),
//   ).obs;

//   // Filter state
//   var isFilterVisible = false.obs;
//   var selectedOrderTypes = <String>[].obs;
//   var selectedStatus = <String>[].obs;
//   var selectedDate = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchOrders();
//     updateDateLabel('Daily');
//   }

//    // Update date label based on selected tab (Daily, Weekly, Monthly)
//   void updateDateLabel(String tab) {
//     final now = DateTime.now();
//     switch (tab) {
//       case 'Daily':
//         dateLabel.value = 'Today: ${DateFormat('dd MMM').format(now)}';
//         break;
//       case 'Weekly':
//         dateLabel.value =
//             '${DateFormat('dd MMM').format(dateRange.value.start)} - ${DateFormat('dd MMM').format(dateRange.value.end)}';
//         break;
//       case 'Monthly':
//         dateLabel.value = DateFormat('MMM yyyy').format(now);
//         break;
//     }
//   }

//   // Open date picker for setting date range
//   Future<void> openDatePicker(BuildContext context, String tab) async {
//     switch (tab) {
//       case 'Daily':
//         final pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2020),
//           lastDate: DateTime.now(),
//         );
//         if (pickedDate != null) {
//           dateRange.value = DateTimeRange(start: pickedDate, end: pickedDate);
//           updateDateLabel('Daily');
//         }
//         break;
//       case 'Weekly':
//         final pickedRange = await showDateRangePicker(
//           context: context,
//           firstDate: DateTime(2020),
//           lastDate: DateTime.now(),
//           initialDateRange: DateTimeRange(
//             start: now.subtract(const Duration(days: 7)),
//             end: now,
//           ),
//         );
//         if (pickedRange != null) {
//           dateRange.value = pickedRange;
//           updateDateLabel('Weekly');
//         }
//         break;
//       case 'Monthly':
//         final pickedMonth = await showDatePicker(
//           context: context,
//           initialDate: now,
//           firstDate: DateTime(2020),
//           lastDate: now,
//           selectableDayPredicate: (date) =>
//               date.day == 1 || date == DateTime(now.year, now.month + 1, 0),
//         );
//         if (pickedMonth != null) {
//           dateRange.value = DateTimeRange(
//             start: DateTime(pickedMonth.year, pickedMonth.month, 1),
//             end: DateTime(pickedMonth.year, pickedMonth.month + 1, 0),
//           );
//           updateDateLabel('Monthly');
//         }
//         break;
//     }
//   }

//   void fetchOrders() async {
//     try {
//       isLoading(true);
//       isError(false);
//       await Future.delayed(const Duration(seconds: 2));
//       var fetchedOrders = [
//         OrderModel(
//           orderId: '#12345',
//           orderNumber: '#85768',
//           status: 'Ongoing',
//           totalAmount: '₹100',
//           orderType: 'Food',
//           userId: '#5234',
//           userName: 'Biswa',
//           date: 'Aug 13, 2024',
//           time: '1:34 PM',
//           phoneNumber: '+91 91999919119',
//         ),
//         OrderModel(
//           orderId: '#12346',
//           orderNumber: '#85769',
//           status: 'Order Ready',
//           totalAmount: '₹200',
//           orderType: 'Drink',
//           userId: '#5234',
//           userName: 'John',
//           date: 'Aug 14, 2024',
//           time: '2:34 PM',
//           phoneNumber: '+91 91999919220',
//         ),
//         OrderModel(
//           orderId: '#12347',
//           orderNumber: '#85770',
//           status: 'Order Ready',
//           totalAmount: '₹300',
//           orderType: 'Snack',
//           userId: '#5234',
//           userName: 'Sarah',
//           date: 'Aug 15, 2024',
//           time: '3:34 PM',
//           phoneNumber: '+91 91999919330',
//         ),
//         OrderModel(
//           orderId: '#12348',
//           orderNumber: '#85771',
//           status: 'Ongoing',
//           totalAmount: '₹150',
//           orderType: 'Food',
//           userId: '#5234',
//           userName: 'Chris',
//           date: 'Aug 16, 2024',
//           time: '4:34 PM',
//           phoneNumber: null,
//         ),
//         OrderModel(
//           orderId: '#12349',
//           orderNumber: '#85772',
//           status: 'Order Ready',
//           totalAmount: '₹250',
//           orderType: 'Drink',
//           userId: '#5234',
//           userName: 'Alex',
//           date: 'Aug 17, 2024',
//           time: '5:34 PM',
//           phoneNumber: '+91 91999919550',
//         ),
//         OrderModel(
//           orderId: '#12345',
//           orderNumber: '#85772',
//           status: 'Completed',
//           totalAmount: '₹599',
//           orderType: 'Food',
//           userId: '#1903',
//           userName: 'Iva Ryan',
//           date: 'Aug 13, 2024',
//           time: '1:34 PM',
//           phoneNumber: '+91 91999919550',
//         ),
//       ];

//       orderList.value = fetchedOrders;
//       allOrders.value = fetchedOrders; // Keep a copy for search filtering
//     } catch (e) {
//       isError(true);
//     } finally {
//       isLoading(false);
//     }
//   }

// // Toggle filter visibility
//   void toggleFilterVisibility() {
//     isFilterVisible.value = !isFilterVisible.value;
//   }

//   // Add or remove selected filters
//   void toggleStatusFilter(String status) {
//     if (selectedStatus.contains(status)) {
//       selectedStatus.remove(status);
//     } else {
//       selectedStatus.add(status);
//     }
//   }

//   void toggleOrderTypeFilter(String orderType) {
//     if (selectedOrderTypes.contains(orderType)) {
//       selectedOrderTypes.remove(orderType);
//     } else {
//       selectedOrderTypes.add(orderType);
//     }
//   }

//   // Set or reset selected date
//   void setDateFilter(String date) {
//     selectedDate.value = date;
//   }

//   void applyFilters() {
//     orderList.assignAll(allOrders.where((order) {
//       bool matchesStatus =
//           selectedStatus.isEmpty || selectedStatus.contains(order.status);
//       bool matchesType = selectedOrderTypes.isEmpty ||
//           selectedOrderTypes.contains(order.orderType);
//       bool matchesDate =
//           selectedDate.value.isEmpty || selectedDate.value == order.date;
//       return matchesStatus && matchesType && matchesDate;
//     }).toList());
//   }

//   // Clear filters
//   void clearFilters() {
//     selectedStatus.clear();
//     selectedOrderTypes.clear();
//     selectedDate.value = '';
//     applyFilters();
//   }

//   // Search filter method
//   void filterOrders(String query) {
//     if (query.isEmpty) {
//       orderList.value = allOrders;
//     } else {
//       orderList.value = allOrders
//           .where((order) =>
//               order.userName.toLowerCase().contains(query.toLowerCase()) ||
//               order.orderId.contains(query) ||
//               order.orderNumber.contains(query))
//           .toList();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_vendor_app/models/home/corrent_order_ststus_model.dart';

class CurrentOrderController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  var orderList = <OrderModel>[].obs;
  var allOrders = <OrderModel>[].obs;

  var filteredOrders = <OrderModel>[].obs;
  var searchHistory = <String>[].obs; // Store search history

  // Mock data for status and order types
  final List<String> statusOptions = ['Ongoing', 'Order Ready', 'Completed'];
  final List<String> orderTypeOptions = ['Food', 'Drink'];

  var selectedStatuses = <String>[].obs;
  var selectedOrderTypes = <String>[].obs;
  var dateLabel = 'Select Date'.obs;
  var dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  ).obs;

  var selectedTab = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void toggleStatusFilter(String status, bool isSelected) {
    if (isSelected) {
      selectedStatuses.add(status);
    } else {
      selectedStatuses.remove(status);
    }
    applyFilters();
  }

  void toggleOrderTypeFilter(String orderType, bool isSelected) {
    if (isSelected) {
      selectedOrderTypes.add(orderType);
    } else {
      selectedOrderTypes.remove(orderType);
    }
    applyFilters();
  }

  // Update date label based on selected tab
  void updateDateLabel(String tab) {
    selectedTab.value = tab;
    final now = DateTime.now();
    switch (tab) {
      case 'Daily':
        dateLabel.value = 'Today: ${DateFormat('dd MMM').format(now)}';
        break;
      case 'Custom':
        dateLabel.value =
            '${DateFormat('dd MMM').format(dateRange.value.start)} - ${DateFormat('dd MMM').format(dateRange.value.end)}';
        break;
      case 'Monthly':
        dateLabel.value = DateFormat('MMM yyyy').format(now);
        break;
      case 'All':
        dateLabel.value = 'All Orders';
        break;
    }
    applyFilters();
  }

  // Open date picker for selecting date range
  Future<void> openDatePicker(BuildContext context, String tab) async {
    final now = DateTime.now();
    switch (tab) {
      case 'Daily':
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(2020),
          lastDate: now,
        );
        if (pickedDate != null) {
          dateRange.value = DateTimeRange(start: pickedDate, end: pickedDate);
          updateDateLabel('Daily');
        }
        break;
      case 'Custom':
        final pickedRange = await showDateRangePicker(
          context: context,
          initialDateRange: DateTimeRange(
              start: now.subtract(const Duration(days: 7)), end: now),
          firstDate: DateTime(2020),
          lastDate: now,
        );
        if (pickedRange != null) {
          dateRange.value = pickedRange;
          updateDateLabel('Weekly');
        }
        break;
      case 'Monthly':
        final pickedMonth = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(2020),
          lastDate: now,
          selectableDayPredicate: (date) =>
              date.day == 1 || date == DateTime(now.year, now.month + 1, 0),
        );
        if (pickedMonth != null) {
          dateRange.value = DateTimeRange(
            start: DateTime(pickedMonth.year, pickedMonth.month, 1),
            end: DateTime(pickedMonth.year, pickedMonth.month + 1, 0),
          );
          updateDateLabel('Monthly');
        }
        break;
    }
  }

  // Fetch dummy order data
  void fetchOrders() async {
    try {
      isLoading(true);
      isError(false);
      await Future.delayed(const Duration(seconds: 1));
      var fetchedOrders = List<OrderModel>.generate(10, (index) {
        DateTime date = DateTime.now().subtract(Duration(days: index));
        return OrderModel(
          orderId: '#1234${index}',
          orderNumber: '#8576${index}',
          status: index % 2 == 0 ? 'Ongoing' : 'Order Ready',
          totalAmount: '₹${(index + 1) * 100}',
          orderType: index % 2 == 0 ? 'Food' : 'Drink',
          userId: '#52${index}',
          userName: 'User ${index + 1}',
          date: DateFormat('MMM dd, yyyy').format(date),
          time: DateFormat('h:mm a').format(date),
          phoneNumber: '+91 91999919${100 + index}',
        );
      });

      orderList.value = fetchedOrders;
      allOrders.value = fetchedOrders;
    } catch (e) {
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  // Apply filters based on selected tab and status/order type selections
  void applyFilters() {
    List<OrderModel> filteredOrders = allOrders;

    // Filter by date based on selectedTab
    switch (selectedTab.value) {
      case 'Daily':
        filteredOrders = filteredOrders
            .where((order) =>
                order.date ==
                DateFormat('MMM dd, yyyy').format(dateRange.value.start))
            .toList();
        break;
      case 'Weekly':
        filteredOrders = filteredOrders.where((order) {
          DateTime orderDate = DateFormat('MMM dd, yyyy').parse(order.date);
          return orderDate.isAfter(
                  dateRange.value.start.subtract(const Duration(days: 1))) &&
              orderDate
                  .isBefore(dateRange.value.end.add(const Duration(days: 1)));
        }).toList();
        break;
      case 'Monthly':
        filteredOrders = filteredOrders.where((order) {
          DateTime orderDate = DateFormat('MMM dd, yyyy').parse(order.date);
          return orderDate.month == dateRange.value.start.month &&
              orderDate.year == dateRange.value.start.year;
        }).toList();
        break;
      default:
        break;
    }

    // Apply additional filters by status and order type
    if (selectedStatuses.isNotEmpty) {
      filteredOrders = filteredOrders
          .where((order) => selectedStatuses.contains(order.status))
          .toList();
    }
    if (selectedOrderTypes.isNotEmpty) {
      filteredOrders = filteredOrders
          .where((order) => selectedOrderTypes.contains(order.orderType))
          .toList();
    }

    orderList.assignAll(filteredOrders);
  }

  // Handle the search functionality
  void filterOrders(String query) {
    if (query.isEmpty) {
      filteredOrders.value = orderList; // Show all orders if no search query
    } else {
      filteredOrders.value = orderList
          .where((order) =>
              order.userName.toLowerCase().contains(query.toLowerCase()) ||
              order.orderId.contains(query) ||
              order.orderNumber.contains(query))
          .toList();
    }
  }
}
