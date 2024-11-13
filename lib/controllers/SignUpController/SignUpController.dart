import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_vendor_app/controllers/EmailController/EmailController.dart';
import 'package:restaurant_vendor_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
import 'package:restaurant_vendor_app/controllers/UserController/UserController.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restaurant_vendor_app/firebase/StorageMethods/StorageMethods.dart';
import 'package:restaurant_vendor_app/models/PhoneNumberModel/PhoneNumber.model.dart';
import 'package:restaurant_vendor_app/models/ResponseModel/ResponseModel.dart';
import 'package:restaurant_vendor_app/models/SignUpModel/SignUp.model.dart';
import 'package:restaurant_vendor_app/utils/imagePicker.dart';

class SignUpController extends GetxController {
  var signUpModel = SignUpModel().obs;
  final RxInt _page = 0.obs;
  PhoneNumberController phoneNumberController =
      Get.put(PhoneNumberController());
  EmailController emailController = Get.put(EmailController(), permanent: true);
  final _authMethods = Get.find<AuthMethods>();
  final userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    signUpModel.value.phoneNumber = PhoneNumberModel(
      phoneNumber: phoneNumberController.phoneNumber ?? userController.currentUser.value.phone?.phoneNumber,
      countryCode: userController.currentUser.value.phone?.countryCode ?? phoneNumberController.selectedCountryCode,
    );
    signUpModel.value.name = userController.name;
    emailController.emailAddress = userController.email;
    signUpModel.value.email = emailController.emailAddress;
  }

  int get page => _page.value;
  String? get emailAdress => emailController.emailAddress;
  String? get phoneNumber => phoneNumberController.phoneNumber;
  String? get countryCode => signUpModel.value.phoneNumber!.countryCode;
  String? get countryFlag => phoneNumberController.selectedCountryFlag;
  String? get name => signUpModel.value.name;
  String? get dateOfBirth => signUpModel.value.dateOfBirth;
  String? get gender => signUpModel.value.gender;
  File? get profilePic => signUpModel.value.profilePic;
  bool? get whatsAppMessagePreference =>
      signUpModel.value.sendMessageViaWhatsApp;
  String? get restaurantName => signUpModel.value.restaurantName;
  String? get address1 => signUpModel.value.address1;
  String? get address2 => signUpModel.value.address2;
  String? get city => signUpModel.value.city;
  String? get country => signUpModel.value.country;
  String? get state => signUpModel.value.state;
  int? get pinCode => signUpModel.value.pinCode;
  set page(int value){
    _page.value = value;
  }

  Future<void> selectImage() async {
    final file = await pickImage(ImageSource.gallery);
    signUpModel.update((model) {
      model?.profilePic = file;
    });
  }

  void submit() async {
    signUpModel.value.phoneNumber =
        phoneNumberController.phoneNumberModel.value;
    signUpModel.value.email = emailController.emailAddress;
    final userData = Get.find<UserController>();
    final restaurentController = Get.find<RestaurantController>();

    // upload profile pic to firebase if provided
    String? downloadUrl;
    if (profilePic != null) {
      final res = await StorageMethods().uploadRestaurantPic(file: profilePic!);
      if (res.message == "success") {
        downloadUrl = res.data;
      } else {
        if (kDebugMode) {
          debugPrint(res.message!);
        }
      }
    }
    late ResponseModel res,res2;
    // loggedIn flag indicates that user has account or not
    if (!_authMethods.loggedIn) {
      userData.updateUserDetails(
        name: name,
        dateOfBirth: dateOfBirth,
        gender: gender,
        phone: phoneNumberController.phoneNumberModel.value,
        profilePic: null,
        email: emailAdress,
        whatsAppMessagePreference: whatsAppMessagePreference,
      );
      // storing user data in backend
      res = await _authMethods.createAccount(userData.user);
    }
    if (_authMethods.loggedIn || res.message == "success") {
      restaurentController.updateRestaurantDetails(
          address1: address1,
          address2: address2,
          pinCode: pinCode,
          city: city,
          country: country,
          state: state,
          restaurantName: restaurantName,
        photoUrl: downloadUrl,
      );
      res2 = await _authMethods
          .createRestaurentAccount(restaurentController.current);
      if (res2.message == 'success') {
        await _authMethods.startSession();
        if(restaurentController.verified ?? false){
          Get.offAllNamed('/dashboard');
        }else{
          Get.offAllNamed('/verification_screen');
        }
      }else{
        if (kDebugMode) debugPrint(res2.message);
        Get.offAllNamed('/signup2'); 
      }
    } else {
      if (kDebugMode) debugPrint(res.message);
      userData.clearUserData();
      restaurentController.clearData();
      Get.offAllNamed('/login');
    }
  }
  String? validate({required String? value,required String message}){
    if(value == null || value.isEmpty){
      return message;
    }
    return null;
  }

  String? validatePhoneNumber() {
    return phoneNumberController.validate();
  }

  String? validateEmail() {
    if (!emailController.validate()) {
      return "Invalid Email address";
    }
    return null;
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2100);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(253, 71, 18, 1),
            colorScheme: const ColorScheme.light(primary: Color.fromRGBO(253, 71, 18, 1)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (picked != null && picked != initialDate) {
      signUpModel.update((model) {
        model?.dateOfBirth = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void updateDetails({
    String? name,
    String? dateOfBirth,
    String? gender,
    PhoneNumberModel? phoneNumber,
    String? email,
    bool sendMessageViaWhatsApp = false,
    File? profilePic,
    String? address1,
    String? address2,
    int? pinCode,
    String? city,
    String? state,
    String? country,
    String? restaurantName,
  }) {
    final newModel = signUpModel.value.copyWith(
      name: name,
      dateOfBirth: dateOfBirth,
      gender: gender,
      phoneNumber: phoneNumber,
      email: email,
      sendMessageViaWhatsApp: sendMessageViaWhatsApp,
      profilePic: profilePic,
      address1: address1,
      address2: address2,
      pinCode: pinCode,
      city: city,
      state: state,
      country: country,
      restaurantName: restaurantName
    );
    if(email != null) emailController.updateEmailAddress(email);
    if(phoneNumber != null) phoneNumberController.updatePhoneNumber(phoneNumber.phoneNumber!);
    
    signUpModel.value = newModel;
  }
}
