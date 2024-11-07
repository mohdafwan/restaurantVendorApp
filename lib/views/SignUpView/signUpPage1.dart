import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/SignUpController/SignUpController.dart';
import 'package:restaurant_vendor_app/views/SignUpView/components/dateField.dart';
import 'package:restaurant_vendor_app/views/SignUpView/components/emailField.dart';
import 'package:restaurant_vendor_app/views/SignUpView/components/genderField.dart';
import 'package:restaurant_vendor_app/views/SignUpView/components/messagePerference.dart';
import 'package:restaurant_vendor_app/views/SignUpView/components/inputTextField.dart';
import 'package:restaurant_vendor_app/views/SignUpView/components/phoneNoField.dart';
import 'package:restaurant_vendor_app/widgets/TermsAndConditions.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';

class SignUpPage1 extends StatefulWidget {
  const SignUpPage1({super.key});

  @override
  _SignUpPage1State createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
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
    controller.page = 1;
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
              const SizedBox(height: 30),
              // Name section
              InputTextField(
                  label: 'Admin Name',
                  prefill: controller.name,
                  hintText: "Enter your name here",
                  onChanged: (text) => controller.updateDetails(name: text),
                  validator: (_) => controller.validate(
                      value: controller.name, message: 'Please provide name')),
              const SizedBox(height: 16),
              // DOB section
              const DateField(),
              const SizedBox(height: 16),
              // Gender section
              const GenderField(),
              const SizedBox(height: 16),
              // Phone Number section
              const PhoneNoField(),
              const SizedBox(height: 16),
              // Email section
              const EmailField(),
              const SizedBox(height: 30),
              // WhatsApp perference section --> checkbox
              const MessagePerference(),
              const SizedBox(height: 30),
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
