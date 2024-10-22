import 'dart:io';
import 'package:restaurant_vendor_app/models/PhoneNumberModel/PhoneNumber.model.dart';

class SignUpModel {
  String? name;
  String? dateOfBirth;
  String? gender;
  PhoneNumberModel? phoneNumber;
  String? email;
  bool sendMessageViaWhatsApp = false;
  File? profilePic; // need to upload and store download url

  SignUpModel({
    this.name,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.email,
  });
}
