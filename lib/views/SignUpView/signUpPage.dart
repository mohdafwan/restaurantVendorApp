import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/ColorPalette.dart';
import 'package:restaurant_vendor_app/controllers/SignUpController/SignUpController.dart';
import 'package:restaurant_vendor_app/views/SignUpView/signUpPage1.dart';
import 'package:restaurant_vendor_app/views/SignUpView/signUpPage2.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool signUpUsingPhone = true;
  final SignUpController controller = Get.put(SignUpController());
  final List<Widget> pages = [
    const SignUpPage1(),
    const SignUpPage2()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 44, top: 33),
          child: Text(
            "Personal Details",
            style: GoogleFonts.inter(
              color: fontColor,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              height: 1.3,
            ),
          ),
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
      ),
      body: Obx(() {
          return pages[controller.page];
        }
      )
    );
  }
}
