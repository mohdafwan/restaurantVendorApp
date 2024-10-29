import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/SignUpController/SignUpController.dart';
import 'package:restaurant_vendor_app/views/SignUpView/components/inputTextField.dart';
import 'package:restaurant_vendor_app/views/SignUpView/components/profilePic.dart';
import 'package:restaurant_vendor_app/views/SignUpView/components/CustomCountryStateCityPackage.dart';
import 'package:restaurant_vendor_app/views/VerifyEmailUsingOTP/VerifyEmailUsingOTP.dart';
import 'package:restaurant_vendor_app/widgets/TermsAndConditions.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({super.key});

  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  final _formKey = GlobalKey<FormState>();
  bool signUpUsingPhone = true;
  final SignUpController controller = Get.put(SignUpController());
  bool clicked = false;

  @override
  void initState() {
    if (controller.emailAdress != null) {
      signUpUsingPhone = false;
    }
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    Get.to(()=>const VerifyEmailUsingOTP());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const Center(
                child: ProfilePic(),
              ),
              const SizedBox(height: 16),
              // Name section
              InputTextField(
                label: 'Restaurant Name',
                hintText: "Enter your Restaurant name here",
                onChanged: (text) => controller.updateDetails(restaurantName: text),
                validator: (_) => controller.validate(value: controller.restaurantName,message: "Please provide restaurant name"),
              ),
              const SizedBox(height: 16),
              // Address line 1
              InputTextField(
                label: 'Address Line 1',
                hintText: "Enter here",
                onChanged: (text) => controller.updateDetails(address1: text),
                validator: (_) => controller.validate(value: controller.address1,message: 'Please provide address'),
              ),
    
              const SizedBox(height: 16),
              // Address line 2
              InputTextField(
                label: 'Address Line 2',
                hintText: "Enter here",
                onChanged: (text) => controller.updateDetails(address2: text),
              ),
    
              const SizedBox(height: 16),
              // pin code
              InputTextField(
                label: 'Pin Code',
                hintText: "Enter here",
                digitsOnly: true,
                onChanged: (text) => controller.updateDetails(pinCode: text),
              ),

              const SizedBox(height: 16),
              CustomSelectState(
                onCountryChanged: (value) {
                  setState(() {
                    controller.updateDetails(country: value);
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    controller.updateDetails(state: value);
                  });
                },
                onCustomCityChanged: (value) {
                  setState(() {
                    controller.updateDetails(city: value);
                  });
                },
              ),
              const SizedBox(height: 16),
    
              // Create Account Button
              Button(
                onPressed: _submitForm,
                text: "Create account",
                disable: clicked,
              ),
              const SizedBox(height: 30),
              // Terms & conditions
              const Center(
                child: TermsAndConditons(),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
