import 'dart:io';
import 'package:restaurant_vendor_app/models/PhoneNumberModel/PhoneNumber.model.dart';

class SignUpModel {
  String? name;
  String? dateOfBirth;
  String? gender;
  PhoneNumberModel? phoneNumber;
  String? email;
  bool sendMessageViaWhatsApp;
  File? profilePic;
  String? address1;
  String? address2;
  int? pinCode;
  String? city;
  String? state;
  String? country;
  String? restaurantName;

  SignUpModel({
    this.name,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.email,
    this.sendMessageViaWhatsApp = false,
    this.profilePic,
    this.address1,
    this.address2,
    this.pinCode,
    this.city,
    this.state,
    this.country,
    this.restaurantName,
  });

  SignUpModel copyWith({
    String? name,
    String? dateOfBirth,
    String? gender,
    PhoneNumberModel? phoneNumber,
    String? email,
    bool? sendMessageViaWhatsApp,
    File? profilePic,
    String? address1,
    String? address2,
    int? pinCode,
    String? city,
    String? state,
    String? country,
    String? restaurantName,
  }) {
    return SignUpModel(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      sendMessageViaWhatsApp: sendMessageViaWhatsApp ?? this.sendMessageViaWhatsApp,
      profilePic: profilePic ?? this.profilePic,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      pinCode: pinCode ?? this.pinCode,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      restaurantName: restaurantName ?? this.restaurantName,
    );
  }
}
