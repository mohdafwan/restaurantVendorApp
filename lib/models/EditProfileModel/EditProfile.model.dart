import 'package:restaurant_vendor_app/models/PhoneNumberModel/PhoneNumber.model.dart';

class EditProfileModel {
  String? name;
  String? dateOfBirth;
  String? gender;
  PhoneNumberModel? phoneNumber;
  String? email;
  String? profilePic;

  EditProfileModel({
    this.name,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.email,
  });
}
