import 'package:get/get.dart';
import 'package:restaurant_vendor_app/models/RestaurantModel/Restaurant.model.dart';

class RestaurantController extends GetxController {
  Rx<RestaurantModel> model = RestaurantModel().obs;

  RestaurantModel get current => model.value;
  bool? get verified => model.value.verified;
  String? get address1 => model.value.address1;
  String? get address2 => model.value.address2;
  String? get pinCode => model.value.pinCode;
  String? get city => model.value.city;
  String? get state => model.value.state;
  String? get country => model.value.country;
  String? get restaurantName => model.value.restaurantName;
  String? get photoUrl => model.value.photoUrl;
  int? get id => model.value.id;

  void setModel(RestaurantModel newModel){
    model.value = newModel;
  }

   void updateRestaurantDetails({
    String? address1,
    String? address2,
    String? pinCode,
    String? city,
    String? state,
    String? country,
    String? restaurantName,
    String? photoUrl,
    int? id,
    bool? verified
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
      verified: verified ?? model.value.verified
    );

    model.value = updatedRestaurant;
  }

  void clearData(){
    model.value = RestaurantModel();
  }
}
