import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restaurant_vendor_app/models/ResponseModel/ResponseModel.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    _initializeApp();
    super.onReady();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(
        const Duration(seconds: 5)); // will remove in production

    final authMethods = Get.find<AuthMethods>();


    // Listen to auth state changes
    authMethods.authChanges.listen((user) async {
      if (user != null) {
        // If a user is signed in, fetch user data
        try {
          final ResponseModel response = await authMethods.getUserData();
          if (response.message == "success") {
            // get restaurent data 
            // todo : send fcm token to backend
            Get.offAllNamed('/dashboard');
          } else{
            // go to signup route
            Get.offAllNamed('/signup');
          }
        } catch (error) {
          if (kDebugMode) debugPrint('Error fetching user data: $error');
          Get.offAllNamed('/login');
        }
      } else {
        Get.offAllNamed('/login');
      }
    });
  }
}
