import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restaurant_vendor_app/models/RestaurantModel/Restaurant.model.dart';
import 'package:restaurant_vendor_app/models/label/label.model.dart';

class RestaurantController extends GetxController {
  Rx<RestaurantModel> model = RestaurantModel().obs;
  final dio.Dio _dio = dio.Dio();

  RestaurantModel get current => model.value;
  bool? get verified => model.value.verified;
  String? get address1 => model.value.address1;
  String? get address2 => model.value.address2;
  int? get pinCode => model.value.pinCode;
  String? get city => model.value.city;
  String? get state => model.value.state;
  String? get country => model.value.country;
  String? get restaurantName => model.value.restaurantName;
  String? get photoUrl => model.value.photoUrl;
  int? get id => model.value.id;
  bool? get status => model.value.status;
  List<Label> get labels => model.value.labels;
  
  void setModel(RestaurantModel newModel) {
    model.value = newModel;
  }

  void updateRestaurantDetails({
    String? address1,
    String? address2,
    int? pinCode,
    String? city,
    String? state,
    String? country,
    String? restaurantName,
    String? photoUrl,
    int? id,
    bool? verified,
    bool? status,
    List<Label>? labels,
  }) {
    RestaurantModel updatedRestaurant = model.value.copyWith(
      address1: address1 ?? model.value.address1,
      address2: address2 ?? model.value.address2,
      pinCode: pinCode ?? model.value.pinCode,
      city: city ?? model.value.city,
      state: state ?? model.value.state,
      country: country ?? model.value.country,
      restaurantName: restaurantName ?? model.value.restaurantName,
      photoUrl: photoUrl ?? model.value.photoUrl,
      id: id ?? model.value.id,
      verified: verified ?? model.value.verified,
      status: status ?? model.value.status,
      labels: labels ?? List.from(model.value.labels),
    );
    model.value = updatedRestaurant;
  }
  Future<void> updateLabels(List<Label> newLabels) async {
    model.value.labels = newLabels;
    try{
      final response = await _dio.put(
        "$host/restaurant/$id/",
        data: {
          "labels": newLabels.map((label) => label.toMap()).toList(),
        },
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if(kDebugMode && response.statusCode != 200 ){
        print("error updating labels : ${response.statusMessage}");
      }
    }catch(error){
      if (kDebugMode) {
        print("error updating labels");
      }
    }
  }
  


  void clearData() {
    model.value = RestaurantModel();
  }
}
