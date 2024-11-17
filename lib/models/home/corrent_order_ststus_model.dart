import 'package:intl/intl.dart';

class OrderModel {
  final String orderId;
  final String orderNumber;
  final String status;
  final String totalAmount;
  final List<String> orderType; // Updated to List<String>
  final String userId;
  final String userName;
  final String date;
  final String time;
  final String? phoneNumber;

  OrderModel({
    required this.orderId,
    required this.orderNumber,
    required this.status,
    required this.totalAmount,
    required this.orderType,
    required this.userId,
    required this.userName,
    required this.date,
    required this.time,
    this.phoneNumber,
  });

  // Map of order status conversions
  static const Map<String, String> orderStatusMapping = {
    'ongoing': 'Ongoing',
    'order ready': 'Order Ready',
    'completed': 'Completed',
  };

  // Helper method to get standardized status
  static String getStandardizedStatus(String status) {
    return orderStatusMapping[status.toLowerCase()] ?? 'Unknown Status';
  }

  static String formatDate(String? date) {
    try {
      return date != null && date.isNotEmpty
          ? DateFormat('MMM dd, yyyy').format(DateTime.parse(date))
          : "";
    } catch (e) {
      return ""; // Return empty if the date format is invalid
    }
  }

  static String formatTime(String? time) {
    try {
      if (time != null && time.isNotEmpty) {
        DateTime dateTime = DateTime.parse(time);
        return DateFormat('hh:mm a')
            .format(dateTime); // Format time (e.g., "12:57 PM")
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  // Factory method to create an OrderModel instance from a map
  factory OrderModel.fromMap(Map<String, dynamic> entry) {
    return OrderModel(
      orderId: entry['id'].toString(),
      orderNumber: entry['bill_id'].toString(),
      status: getStandardizedStatus(entry['order_status'] ?? ''),
      totalAmount: entry['amount'].toString(),
      orderType:
          List<String>.from(entry['tag'] ?? []), // Convert to List<String>
      userId: entry['user'].toString(),
      userName: entry['customer_name'],
      date: formatDate(entry['order_date']),

      time: formatTime(entry['delivery_data']),
      phoneNumber: entry['phone_number'],
    );
  }
}
