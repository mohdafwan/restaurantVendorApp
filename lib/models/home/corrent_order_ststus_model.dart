class OrderModel {
  final String orderId;
  final String orderNumber;
  final String status;
  final String totalAmount;
  final String orderType; // Food/Drink
  //user id
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
}
 
