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

  // Factory method to create an OrderModel instance from a map
  factory OrderModel.fromMap(Map<String, dynamic> entry) {
    return OrderModel(
      orderId: entry['id'].toString(),
      orderNumber: entry['bill_id'].toString(),
      status: getStandardizedStatus(entry['order_status'] ?? ''),
      totalAmount: entry['amount'].toString(),
      orderType: List<String>.from(entry['tag'] ?? []), // Convert to List<String>
      userId: entry['user'].toString(),
      userName: entry['customer_name'],
      date: entry['order_date'] != null
          ? DateFormat('MMM dd, yyyy').format(DateTime.parse(entry['order_date']))
          : "",
      time: entry['delivery_data'] ?? '',
      phoneNumber: entry['phone_number'],
    );
  }
}
