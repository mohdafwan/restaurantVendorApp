import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/OTPController/OTPContoller.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
import 'package:restaurant_vendor_app/controllers/UserController/UserController.dart';
import 'package:restaurant_vendor_app/models/ResponseModel/ResponseModel.dart';
import 'package:restaurant_vendor_app/models/RestaurantModel/Restaurant.model.dart';
import 'package:restaurant_vendor_app/models/UserModel/UserModel.dart';
import 'package:restaurant_vendor_app/utils/toastMessage.dart';

// http://10.0.2.2:8000 for emulation
// replace with your machine ip address to test on real device
const host = "http://192.168.1.10:8000";
const wsHost = "ws://192.168.1.10:8000";
// const host = "http://192.168.29.48:8000";
// const wsHost = "ws://192.168.29.48:8000";
//const host = "http://192.168.29.88:8000";
//const wsHost = "ws://192.168.29.88:8000";
// 192.168.1.5
//192.168.29.48

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserController _userController =
      Get.put(UserController(), permanent: true);

  final RestaurantController _restaurantController =
      Get.put(RestaurantController(), permanent: true);
  final dio.Dio _dio = dio.Dio();
  bool loggedIn = false;
  bool justLoggedIn = false;
  late String fcmToken;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User? get user => _auth.currentUser;

  Map<String, String> routes = {
    "create_user": "$host/user/",
    "get_user": "$host/user_check/",
    "email_otp": "$host/otp/",
    "update_user": "$host/user/",
    "restaurant": "$host/restaurant/",
    "get_restaurent": "$host/restuarant_check/",
    "start_session": "$host/startsession/",
    "check_session": "$host/sessioncheck/",
    "logout":"$host/logoutsession/"
  };

  Future<ResponseModel> signInUsingPhoneNumber() async {
    final otpController = Get.find<OTPController>();
    String res = "some error occurred";
    try {
      String verificationId = otpController.verificationId!;
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.otp!,
      );
      if (_userController.uid == null) {
        final userCredential = await _auth.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          _userController.updateUserDetails(uid: user.uid);
          justLoggedIn = true;
          res = "success";
        }
      } else {
        await user?.linkWithCredential(credential);
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        res = error.message ?? "Verification failed. Please try again.";
      } else {
        res = "An unexpected error occurred: $error";
      }
    }
    return ResponseModel(message: res, data: user);
  }

  Future<ResponseModel> sentOTPtoEmail(String email) async {
    String res = "some error occurred";
    String? otp;
    try {
      final response = await _dio.post(routes['email_otp']!, data: {
        "email": email,
      });
      if (response.statusCode == 200) {
        otp = response.data['msg'].toString();
        res = "success";
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res, data: otp);
  }

  void sentOTPtoPhone(
      String e164phoneNumber, int? resendToken, BuildContext context) async {
    final otpController = Get.find<OTPController>();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: e164phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          otpController.pinputController.text = credential.smsCode ?? "";
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            showToastMessage(
                context, "Invalid phone number. Please check and try again.");
          } else if (e.code == 'too-many-requests') {
            showToastMessage(
                context, "Too many requests. Please try again later.");
          } else if (e.code == 'network-request-failed') {
            showToastMessage(context,
                "Network error. Please check your connection and try again.");
          } else if (e.code == 'quota-exceeded') {
            showToastMessage(context,
                "SMS quota exceeded for this project. Try again later.");
          } else if (e.code == 'app-not-authorized') {
            showToastMessage(context,
                "App is not authorized to use Firebase Authentication.");
          } else if (e.code == 'invalid-verification-code') {
            showToastMessage(context, "Invalid verification code.");
          } else {
            showToastMessage(context, "An unknown error occurred.");
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          otpController.verificationId = verificationId;
          otpController.resendToken = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          otpController.verificationId = verificationId;
          // You can add additional logic here if needed
        },
        forceResendingToken: resendToken, // resend otp
      );
    } catch (error) {
      if (context.mounted) {
        showToastMessage(context, "An unexpected error occurred: $error");
      }
    }
  }

  Future<ResponseModel> createAccount(UserModel user) async {
    String res = "some error occurred";
    try {
      final data = {
        'uid': user.uid,
        'username': user.name,
        'email': user.email,
        'phone_number': user.phone?.getE164FormattedPhoneNumber(),
        'profile_image': user.profilePic,
        'gender': user.gender?.toLowerCase(),
        'date_of_birth': user.dateOfBirth,
        'is_active': user.whatsAppMessagePreference,
        'is_superuser': true,
        'password': "temp",
      };

      final response = await _dio.post(
        routes['create_user']!,
        data: data,
      );

      if (response.statusCode == 201) {
        loggedIn = true;
        _userController.updateUserDetails(id: response.data['id']);
        res = "success";
      } else {
        res = response.statusMessage ?? res;
      }
    } catch (error) {
      res = error.toString();
    }

    return ResponseModel(message: res);
  }

  Future<ResponseModel> createRestaurentAccount(RestaurantModel model) async {
    String res = "some error occurred";
    try {
      final data = {
        "restaurant_name": model.restaurantName,
        "address_line1": model.address1,
        "address_line2": model.address2,
        "pin_code": model.pinCode,
        "city": model.city,
        "state": model.state,
        "country": model.country,
        "restaurant_image": model.photoUrl,
        "user": _userController.id,
        "labels": RestaurantModel.initialLabels
            .map((label) => label.toMap())
            .toList(),
      };
      final response = await _dio.post(
        routes['restaurant']!,
        data: data,
      );

      if (response.statusCode == 201) {
        loggedIn = true;

        _restaurantController.updateRestaurantDetails(
            id: response.data['id'], verified: response.data['verify']);
        res = "success";
      } else {
        res = response.statusMessage ?? res;
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res);
  }

  Future<ResponseModel> getUserData() async {
    String res = "some error occurred";
    try {
      String? email = user?.email;
      String? phoneNumber = user?.phoneNumber;
      late ResponseModel response;

      if (email != null || phoneNumber != null) {
        if (email != null) {
          response = await getUserWithEmail(email: email);
        } else if (phoneNumber != null) {
          response = await getUserWithPhoneNumber(e164phoneNumber: phoneNumber);
        }

        if (response.message == "success") {
          _userController.setUser(response.data);
          _userController.updateUserDetails(uid: user!.uid);
          loggedIn = true;
          res = "success";
        } else {
          res = response.message!;
        }
      } else {
        res = "user not found";
      }
    } catch (error) {
      res = error.toString();
    }

    return ResponseModel(message: res);
  }

  Future<ResponseModel> getRestaurentData() async {
    String res = "some error occurred";
    try {
      final data = {'user': _userController.id};
      final response = await _dio.post(
        routes["get_restaurent"]!,
        data: data,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        res = "success";
        _restaurantController.setModel(RestaurantModel.fromMap(response.data));
      } else if (response.statusCode == 404) {
        res = "data not found";
      } else {
        res = response.statusMessage ?? res;
      }
    } catch (error) {
      res = error.toString();
    }

    return ResponseModel(message: res);
  }

  Future<ResponseModel> getUserWithEmail({required String email}) async {
    String res = "some error occurred";
    UserModel? user;
    try {
      final data = {
        'email': email,
      };
      final response = await _dio.post(
        routes['get_user']!,
        data: data,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print(data);
      if (response.statusCode == 200) {
        user = UserModel.fromMap(response.data);
        res = "success";
      } else if (response.statusCode == 404) {
        res = "user not found";
      } else {
        res = response.statusMessage ?? res;
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res, data: user);
  }

  Future<ResponseModel> getUserWithPhoneNumber(
      {required String e164phoneNumber}) async {
    String res = "some error occurred";
    UserModel? user;
    try {
      final data = {'phone_number': e164phoneNumber};
      final response = await _dio.post(
        routes['get_user']!,
        data: data,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        user = UserModel.fromMap(response.data);
        res = "success";
      } else if (response.statusCode == 404) {
        res = "user not found";
      } else {
        res = response.statusMessage ?? res;
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res, data: user);
  }

  Future<ResponseModel> updateUser(UserModel newData) async {
    String res = "some error occurred";
    try {
      final data = {
        'uid': newData.uid,
        'username': newData.name,
        'email': newData.email,
        'phone_number': newData.phone?.getE164FormattedPhoneNumber(),
        'profile_image': newData.profilePic,
        'gender': newData.gender?.toLowerCase(),
        'date_of_birth': newData.dateOfBirth,
        'is_active': newData.whatsAppMessagePreference,
        'password': "temp"
      };

      final response = await _dio.post(
        '${routes['update_user']!}${_userController.id}/',
        data: data,
      );

      if (response.statusCode == 200) {
        res = "success";
      } else {
        res = response.statusMessage ?? res;
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res);
  }

  Future<ResponseModel> startSession() async {
    String res = "some error occurred";
    try {
      String model, platform;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        platform = "android";
        final device = await deviceInfo.androidInfo;
        model = device.model;
      } else if (Platform.isIOS) {
        platform = "ios";
        final device = await deviceInfo.iosInfo;
        model = device.model;
      } else {
        return ResponseModel(message: "device not supported");
      }
      final data = {
        "device": model,
        "id": _userController.id,
        "platform": platform,
        "fcm_token": fcmToken,
        "active": true, // mark true in start
      };
      final response = await _dio.post(
        routes["start_session"]!,
        data: data,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        res = "success";
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res);
  }

  Future<ResponseModel> checkSession() async {
    String res = "some error occurred";
    bool? active;
    try {
      final data = {
        "id": _userController.id,
        "fcm_token": fcmToken,
      };
      final response = await _dio.post(
        routes["check_session"]!,
        data: data,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        active = response.data as bool;
        res = "success";
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res, data: active);
  }

  Future<ResponseModel> signOut() async {
    String res = "some error occurred";
    try {
      await _auth.signOut();
      _userController.clearUserData();
      // send request to backend to end the session
      await _dio.post(
        routes['logout']!,
        data: {
          "id": _userController.id,
          "fcm_token": fcmToken,
        },
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      _userController.clearUserData();
      res = "success";
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res);
  }
}
