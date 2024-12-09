// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
// import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class SocketClient {
//   late WebSocketChannel _channel;
//   static SocketClient? _instance;
//   final restaurentController = Get.find<RestaurantController>();

//   SocketClient._internal() {
//     _channel = WebSocketChannel.connect(
//       Uri.parse("$wsHost/ws/order/"),
//     );

//     final data = {
//       'restaurantId': restaurentController.id,
//     };

//     _channel.sink.add(jsonEncode(data));
//   }

//   static SocketClient get instance {
//     _instance ??= SocketClient._internal();
//     return _instance!;
//   }

//   void listen(Function(dynamic) func) {
//     _channel.stream.listen((message) {
//       final data = jsonDecode(message);
//       func(data);
//     });
//   }

//   void close() {
//     _channel.sink.close();
//   }
// }

// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

// import '../../controllers/RestaurantController/RestaurantController.dart';
// import '../AuthMethods/AuthMethods.dart';

// class SocketClient {
//   late WebSocketChannel _channel;
//   static SocketClient? _instance;
//   final restaurentController = Get.find<RestaurantController>();

//   SocketClient._internal() {
//     try {
//       // Initialize WebSocket connection
//       _channel = WebSocketChannel.connect(
//         Uri.parse("$wsHost/ws/order/"),
//       );

//       final data = {
//         'restaurantId': restaurentController.id,
//       };

//       // Send initial data to the server
//       _channel.sink.add(jsonEncode(data));
//     } catch (e) {
//       // Catch and print errors during initialization
//       print("Error initializing WebSocket: $e");
//     }
//   }

//   static SocketClient get instance {
//     _instance ??= SocketClient._internal();
//     return _instance!;
//   }

//   void listen(Function(dynamic) func) {
//     try {
//       _channel.stream.listen(
//         (message) {
//           try {
//             // Decode and process the incoming message
//             final data = jsonDecode(message);
//             func(data);
//           } catch (e) {
//             // Catch and print JSON decoding errors
//             print("Error decoding WebSocket message: $e");
//           }
//         },
//         onError: (error) {
//           // Handle and print stream errors
//           print("WebSocket error: $error");
//         },
//         onDone: () {
//           // Print when WebSocket stream is closed
//           print("WebSocket connection closed");
//         },
//         cancelOnError: true, // Close stream on error
//       );
//     } catch (e) {
//       // Catch and print errors during stream listening
//       print("Error listening to WebSocket stream: $e");
//     }
//   }

//   void close() {
//     try {
//       // Close WebSocket connection
//       _channel.sink.close(status.goingAway);
//       print("WebSocket connection closed by client");
//     } catch (e) {
//       // Catch and print errors during closure
//       print("Error closing WebSocket connection: $e");
//     }
//   }
// }
import 'dart:convert';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../controllers/RestaurantController/RestaurantController.dart';
import '../AuthMethods/AuthMethods.dart';
import 'dart:io';

class SocketClient {
  late WebSocketChannel _channel;
  static SocketClient? _instance;
  final restaurentController = Get.find<RestaurantController>();

  SocketClient._internal() {
    _connect(); // Initialize WebSocket connection
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }

  void _connect() {
    try {
      print("Attempting to connect to WebSocket...");
      _channel = WebSocketChannel.connect(
        Uri.parse("$wsHost/ws/order/"),
      );

      final data = {
        'restaurantId': restaurentController.id,
      };

      _channel.sink.add(jsonEncode(data));
      print("WebSocket connection established.");
    } on SocketException catch (e) {
      print("SocketException: Unable to connect to the server: $e");
      _retryConnection();
    } on WebSocketChannelException catch (e) {
      print("WebSocketChannelException: $e");
      _retryConnection();
    } catch (e) {
      print("Unexpected error during WebSocket connection: $e");
      _retryConnection();
    }
  }

  void _retryConnection() {
    const int retryInterval = 5; // Retry interval in seconds
    print("Retrying WebSocket connection in $retryInterval seconds...");
    Future.delayed(Duration(seconds: retryInterval), () {
      _connect();
    });
  }

  void listen(Function(dynamic) func) {
    try {
      _channel.stream.listen(
        (message) {
          try {
            final data = jsonDecode(message);
            func(data);
          } catch (e) {
            print("Error decoding WebSocket message: $e");
          }
        },
        onError: (error) {
          print("WebSocket stream error: $error");
          _retryConnection();
        },
        onDone: () {
          print("WebSocket connection closed by server. Reconnecting...");
          _retryConnection();
        },
        cancelOnError: true,
      );
    } on SocketException catch (e) {
      print("SocketException during listen: $e");
      _retryConnection();
    } catch (e) {
      print("Unexpected error during WebSocket listen: $e");
    }
  }

  void close() {
    try {
      _channel.sink.close(status.goingAway);
      print("WebSocket connection closed by client.");
    } catch (e) {
      print("Error while closing WebSocket connection: $e");
    }
  }
}
