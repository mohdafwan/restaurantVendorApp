import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restaurant_vendor_app/models/OrderModel/Order.model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:encrypt/encrypt.dart' as encrypt;

class OrderController extends GetxController {
  var model = OrderModel(tags: []).obs;
  final storage = GetStorage();
  final restaurantController = Get.find<RestaurantController>();
  var items = <Map<String, dynamic>>[].obs;
  final dio.Dio _dio = dio.Dio();

  int? _orderId;

  OrderController({String? encryptedString, int? orderId}) {
    if (encryptedString == null) return;
      _orderId = orderId;
      final data = jsonDecode(
          decryptData(encryptedString, 'HKSJVpYHoYPOXhQpLcqEKTqIGYt82rzp'));
      customerName = data['name'];
      mail = data['email'];
      uid = int.parse(data['uid']);
  }

  String decryptData(String encryptedString, String apiKey) {
    final key = encrypt.Key.fromUtf8(apiKey.padRight(32, '0'));
    final parts = encryptedString.split(':');
    final iv = encrypt.IV.fromBase64(parts[0]);
    final encryptedData = parts[1];

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);

    return decrypted;
  }

  @override
  void onInit() async {
    super.onInit();
    if(_orderId != null){
      findOrderById(id: _orderId!);
    }
    if (storage.read('items') == null) {
      items.assignAll(_initializeListWithPredefinedValues());
      storage.write('items', items);
    } else {
      items.assignAll(List<Map<String, dynamic>>.from(storage.read('items')));
    }
    ever(items, (_) => storage.write('items', items));
  }

  String? get customerName => model.value.customerName;
  String? get phoneNumber => model.value.phoneNumber;
  String? get time => model.value.time;
  String? get date => model.value.date;
  int? get billId => model.value.billId;
  double? get amount => model.value.amount;
  String? get note => model.value.note;
  int? get uid => model.value.uid;
  String? get mail => model.value.mail;
  List<String>? get tags => model.value.tags;

  set customerName(String? value) =>
      model.update((m) => m?.customerName = value);
  set phoneNumber(String? value) => model.update((m) => m?.phoneNumber = value);
  set time(String? value) => model.update((m) => m?.time = value);
  set date(String? value) => model.update((m) => m?.date = value);
  set billId(int? value) => model.update((m) => m?.billId = value);
  set amount(double? value) => model.update((m) => m?.amount = value);
  set note(String? value) => model.update((m) => m?.note = value);
  set uid(int? value) => model.update((m) => m?.uid = value);
  set mail(String? value) => model.update((m) => m?.mail = value);
  set tags(List<String>? value) => model.update((m) => m?.tags = value);

  List<Map<String, dynamic>> _initializeListWithPredefinedValues() {
    List<String> labels = ['Delivered', 'Not Delivered', 'Pickup', 'Order'];
    return labels.map((label) {
      return {
        'label': label,
        'color': _generateRandomColor().value,
      };
    }).toList();
  }

  Color _generateRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      238 + random.nextInt(17),
      238 + random.nextInt(17),
      238 + random.nextInt(17),
      1.0,
    );
  }

  void find({int? uid, String? mail, String? phone}) async {
    try {
      if (uid != null) {
        final response = await _dio.get(
          '$host/user/$uid/',
        );
        if (response.statusCode == 200) {
          customerName = response.data['username'];
          this.mail = response.data['email'];
        }
        return;
      }
      if (mail != null) {
        final data = {
          'email': mail,
        };
        final response = await _dio.post(
          "$host/user_check/",
          data: data,
          options: dio.Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
        if (response.statusCode == 200) {
          this.uid = response.data["id"];
          customerName = response.data['username'];
        }
        return;
      }
      if (phone != null) {
        final data = {'phone_number': phone};
        final response = await _dio.post(
          "$host/user_check/",
          data: data,
          options: dio.Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
        if (response.statusCode == 200) {
          this.uid = response.data["id"];
          customerName = response.data['username'];
          this.mail = response.data['email'];
        }
        return;
      }
    } catch (error) {
      if (kDebugMode){
        debugPrint(
            "Error finding User in OrderController : ${error.toString()}");
      }
    }
  }

  void findOrderById({required int id}) async {
    try {
      final response = await _dio.get(
        '$host/order/$id/',
      );
      if (response.statusCode == 200) {
        customerName = response.data['username'];
        billId = response.data['bill_id'];
        date = response.data["order_date"];
        amount = response.data['amount'];
        note = response.data['note'];
        tags = List<String>.from(response.data['tag'] ?? []);
        uid = response.data['user'];
      }
    } catch (error) {
      if (kDebugMode){
        debugPrint(
            "Error finding Order in OrderController : ${error.toString()}");
      }
    }
  }

  void addElement(String label) {
    final newItem = {
      'label': label,
      'color': _generateRandomColor().value,
    };
    items.add(newItem);
  }

  Future<String?> submit() async {
    try {
      final data = {
        "customer_name": customerName,
        "bill_id": billId,
        "order_date": date,
        "time": time,
        "amount": amount,
        "note": note,
        "tag": tags!
            .map((str) => str.toLowerCase())
            .toList(), // making it lower-case
        "order_status": "ongoing", // initialize with on going
        "user": uid,
        "resturant": restaurantController.id
      };
      late dio.Response response;
      if(_orderId == null){
        response = await _dio.post(
          "$host/order/",
          data: data,
          options: dio.Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
      }else{
        data['id'] = _orderId;
        response = await _dio.put(
          "$host/order/$_orderId/",
          data: data,
          options: dio.Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
      }
      if (response.statusCode != 200 && response.statusCode != 201) {
        if(response.statusCode == 400) return "Order already Exists";
        return "Failed to ${_orderId == null ? 'Create' : 'Edit'} Order";
      }
    } catch (error) {
      return error.toString();
    }
    return null;
  }
}
