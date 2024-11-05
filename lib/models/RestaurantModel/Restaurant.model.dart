import 'dart:convert';

class RestaurantModel {
  String? address1;
  String? address2;
  int? pinCode;
  String? city;
  String? state;
  String? country;
  String? restaurantName;
  String? photoUrl;
  int? id;
  bool? verified;
  RestaurantModel({
    this.address1,
    this.address2,
    this.pinCode,
    this.city,
    this.state,
    this.country,
    this.restaurantName,
    this.photoUrl,
    this.id,
    this.verified = false,
  });

  RestaurantModel copyWith({
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
  }) {
    return RestaurantModel(
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      pinCode: pinCode ?? this.pinCode,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      restaurantName: restaurantName ?? this.restaurantName,
      photoUrl: photoUrl ?? this.photoUrl,
      id: id ?? this.id,
      verified: verified ?? this.verified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address1': address1,
      'address2': address2,
      'pinCode': pinCode,
      'city': city,
      'state': state,
      'country': country,
      'restaurantName': restaurantName,
      'photoUrl': photoUrl,
      'id': id,
      'verified': verified,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      address1: map['address_line1'] != null ? map['address_line1'] as String : null,
      address2: map['address_line2'] != null ? map['address_line2'] as String : null,
      pinCode: map['pin_code'] != null ? map['pin_code'] as int : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      restaurantName: map['restaurant_name'] != null ? map['restaurant_name'] as String : null,
      photoUrl: map['restaurant_image'] != null ? map['restaurant_image'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      verified: map['verify'] != null ? map['verify'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantModel.fromJson(String source) => RestaurantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RestaurantModel(address1: $address1, address2: $address2, pinCode: $pinCode, city: $city, state: $state, country: $country, restaurantName: $restaurantName, photoUrl: $photoUrl, id: $id, verified: $verified)';
  }

  @override
  bool operator ==(covariant RestaurantModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.address1 == address1 &&
      other.address2 == address2 &&
      other.pinCode == pinCode &&
      other.city == city &&
      other.state == state &&
      other.country == country &&
      other.restaurantName == restaurantName &&
      other.photoUrl == photoUrl &&
      other.id == id &&
      other.verified == verified;
  }

  @override
  int get hashCode {
    return address1.hashCode ^
      address2.hashCode ^
      pinCode.hashCode ^
      city.hashCode ^
      state.hashCode ^
      country.hashCode ^
      restaurantName.hashCode ^
      photoUrl.hashCode ^
      id.hashCode ^
      verified.hashCode;
  }
}
