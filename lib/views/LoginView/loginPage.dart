import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/controllers/LoginController/LoginController.dart';
import 'package:restaurant_vendor_app/views/LoginView/components/LoginPhoneNoField.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';
import 'package:restaurant_vendor_app/widgets/TermsAndConditions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 400,
                child: SvgPicture.asset(
                  'assets/loginAssets/Frame.svg',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 44.28,),
              Text(
                'Enter your Phone Number',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: const Color.fromRGBO(30, 30, 30, 1)
                ),
              ),
              const SizedBox(
                  height: 24,
                ),
                const LoginPhoneNoField(),
                const SizedBox(height: 24),
                SizedBox(
                  width: 315,
                  child: Button(
                    onPressed: () => controller.phoneSignIn(context),
                    text: 'Next',
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const TermsAndConditons()
              ],
          ),
        ),
      )
    );
  }
}
