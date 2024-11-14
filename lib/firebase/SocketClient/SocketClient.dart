import 'dart:convert';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketClient {
  late WebSocketChannel _channel;
  static SocketClient? _instance;
  final restaurentController = Get.find<RestaurantController>();

  SocketClient._internal() {
    _channel = WebSocketChannel.connect(
      Uri.parse("$wsHost/order/"),
    );
    
    final data = {
      'restaurantId': restaurentController.id,
    };

    _channel.sink.add(jsonEncode(data));
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }

  void listen(Function(dynamic) func) {
    _channel.stream.listen((message) {
      final data = jsonDecode(message);
      func(data);
    });
  }

  void close() {
    _channel.sink.close();
  }
}
