import 'dart:convert';

class RestaurantModel {
  String? address1;
  String? address2;
  String? pinCode;
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
    String? pinCode,
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
      address1: map['address1'] != null ? map['address1'] as String : null,
      address2: map['address2'] != null ? map['address2'] as String : null,
      pinCode: map['pinCode'] != null ? map['pinCode'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      restaurantName: map['restaurantName'] != null ? map['restaurantName'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      verified: map['verified'] != null ? map['verified'] as bool : null,
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
