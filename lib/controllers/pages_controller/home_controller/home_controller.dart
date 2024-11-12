import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_vendor_app/models/home/corrent_order_ststus_model.dart';

class CurrentOrderController extends GetxController {
  final box = GetStorage();
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
  // var dateLabel = 'Select Date'.obs;
  var selectedTab = 0.obs;
  var dateLabel = ''.obs;
  var selecteddate = DateTime.now().obs;
  var dateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now()).obs;
  var selectedMonth = DateTime.now().month.obs; // Store selected month

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
    setDateLabel();
    loadSearchHistory();
  }

  void toggleStatusFilter(String status, bool isSelected) {
    isSelected ? selectedStatuses.add(status) : selectedStatuses.remove(status);
    applyFilters();
  }

  void toggleOrderTypeFilter(String orderType, bool isSelected) {
    isSelected
        ? selectedOrderTypes.add(orderType)
        : selectedOrderTypes.remove(orderType);
    applyFilters();
  }

  void updateDateLabel(int tab) {
    selectedTab.value = tab;
    //claer all dates
    selecteddate.value = DateTime.now();
    dateRange.value = DateTimeRange(start: DateTime.now(), end: DateTime.now());
    selectedMonth.value = DateTime.now().month;

    setDateLabel();
    applyFilters();
  }

  void setDateLabel() {
    final now = DateTime.now();
    switch (selectedTab.value) {
      case 0:
        dateLabel.value = 'Today:${_formatDate(now)}';
        break;
      case 1:
        dateLabel.value = 'Select Date';
        break;
      case 2:
        dateLabel.value = DateFormat('MMM yyyy').format(now);
        break;
      case 3:
        dateLabel.value = 'All Orders';
        break;
    }
  }

  void selectDate(BuildContext context) async {
    if (selectedTab.value == 0) {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );
      if (pickedDate != null) {
        dateLabel.value = "Today: ${_formatDate(pickedDate)}";
        selecteddate.value = pickedDate;
        applyFilters();
      }
    } else if (selectedTab.value == 1) {
      final pickedRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );
      if (pickedRange != null) {
        dateRange.value = pickedRange;
        dateLabel.value =
            "${_formatDateRange(pickedRange.start)} - ${_formatDateRange(pickedRange.end)}";
        applyFilters();
      }
    } else if (selectedTab.value == 2) {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );
      if (pickedDate != null) {
        selectedMonth.value = pickedDate.month;
        dateLabel.value = _formatMonth(pickedDate);
        applyFilters();
      }
    }
  }

  // Fetch dummy order data
  void fetchOrders() async {
    try {
      isLoading(true);
      isError(false);
      await Future.delayed(const Duration(seconds: 1));
      allOrders.value = List<OrderModel>.generate(300, (index) {
        DateTime date = DateTime.now().subtract(Duration(days: index));
        return OrderModel(
          orderId: '#1234$index',
          orderNumber: '#8576$index',
          status: index % 3 == 0
              ? 'Ongoing'
              : index % 3 == 1
                  ? 'Order Ready'
                  : 'Completed',
          totalAmount: '₹${(index + 1) * 100}',
          orderType: index % 2 == 0 ? 'Food' : 'Drink',
          userId: '#52$index',
          userName: 'User ${index + 1}',
          date: DateFormat('MMM dd, yyyy').format(date),
          time: DateFormat('h:mm a').format(date),
          phoneNumber: '+91 91999919${100 + index}',
        );
      });

      applyFilters();
    } catch (e) {
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  void applyFilters() {
    var tempOrders = List<OrderModel>.from(allOrders);

    if (selectedTab.value == 0) {
      tempOrders.retainWhere(
          (order) => _isSameDay(_parseDate(order.date), selecteddate.value));
    } else if (selectedTab.value == 1) {
      // Orders in selected date range
      tempOrders.retainWhere((order) {
        DateTime orderDate = _parseDate(order.date);
        return orderDate.isAfter(dateRange.value.start) &&
            orderDate.isBefore(dateRange.value.end);
      });
    } else if (selectedTab.value == 2) {
      tempOrders.retainWhere((order) {
        DateTime orderDate = _parseDate(order.date);
        return orderDate.month == selectedMonth.value &&
            orderDate.year == DateTime.now().year; // Filter by selected month
      });
    }

    if (selectedStatuses.isNotEmpty) {
      tempOrders
          .retainWhere((order) => selectedStatuses.contains(order.status));
    }
    if (selectedOrderTypes.isNotEmpty) {
      tempOrders
          .retainWhere((order) => selectedOrderTypes.contains(order.orderType));
    }

    orderList.assignAll(tempOrders);
  }

  bool _isSameDay(DateTime date1, DateTime date2) =>
      date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;

  //make date formate like 22 - 12 - 21 make this formate of year show 2 only 2024 this year so show only 24
  //make fuction this formate
  String _formatDate(DateTime date) {
    return DateFormat('dd - MMM - yy').format(date);
  }

  String _formatDateRange(DateTime date) {
    return DateFormat('dd-MM-yy').format(date);
  }

  String _formatMonth(DateTime date) => DateFormat('MMM yyyy').format(date);
  DateTime _parseDate(String date) => DateFormat('MMM dd, yyyy').parse(date);
  // Handle the search functionality
  void filterOrders(String query) {
    if (query.isEmpty) {
      filteredOrders.value = allOrders; // Show all orders if no search query
    } else {
      filteredOrders.value = allOrders
          .where((order) =>
              order.userName.toLowerCase().contains(query.toLowerCase()) ||
              order.orderId.contains(query) ||
              order.orderNumber.contains(query))
          .toList();
    }
  }

  void loadSearchHistory() {
    final savedHistory = box.read('searchHistory');
    if (savedHistory != null && savedHistory is List) {
      searchHistory.assignAll(List<String>.from(savedHistory));
    }
  }

  void saveSearchHistory(String searchQuery) {
    if (searchQuery.isNotEmpty && !searchHistory.contains(searchQuery)) {
      searchHistory.insert(0, searchQuery);
      box.write('searchHistory', searchHistory);
    }
  }

  void clearSearchHistoryItem(String searchItem) {
    searchHistory.remove(searchItem);
    box.write('searchHistory', searchHistory);
  }
}
