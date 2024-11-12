import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
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
    final restaurentController = Get.find<RestaurantController>();


    // Listen to auth state changes
    authMethods.authChanges.listen((user) async {
      if (user != null) {
        // If a user is signed in, fetch user data
        try {
          final ResponseModel response = await authMethods.getUserData();
          if (response.message == "success") {
            final res = await authMethods.getRestaurentData(); 
            // if restaurent data is not present
            if(res.message == "data not found"){
              Get.offAllNamed('/signup2');
            }else if(res.message == "success"){
              if(authMethods.justLoggedIn){
                //todo : create/resume session
              }else{
                // todo : check if session is active , if not... end current session and signout user 
              }
              if(restaurentController.verified ?? false){
                Get.offAllNamed('/dashboard');
              }else{
                Get.offAllNamed('/verification_screen');
              }
            }
          } else{
            // go to signup route
            Get.offAllNamed('/signup');
          }
        } catch (error) {
          if (kDebugMode) debugPrint('Error fetching user data: $error');
          Get.offAllNamed('/login');
        }
      } else {
        authMethods.loggedIn = false; // set login state to false
        Get.offAllNamed('/login');
      }
    });
  }
}
