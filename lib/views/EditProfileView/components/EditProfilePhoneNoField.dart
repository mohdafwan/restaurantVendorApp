import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/ColorPalette.dart';
import 'package:restaurant_vendor_app/controllers/EditProfileController/EditProfileController.dart';
import 'package:restaurant_vendor_app/views/UpdateNumberDetails/UpdateNumberDetails.dart';


class EditProfilePhoneNoField extends StatefulWidget {
  const EditProfilePhoneNoField({super.key});

  @override
  State<EditProfilePhoneNoField> createState() =>
      _EditProfilePhoneNoFieldState();
}

class _EditProfilePhoneNoFieldState extends State<EditProfilePhoneNoField> {
  final controller = Get.find<EditProfileController>();
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    phoneController.text = controller.phoneNumber ?? '';
    ever(controller.phoneNumberController.phoneNumberModel, (value) {
      phoneController.text = value.phoneNumber ?? '';
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone number",
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(32, 37, 56, 1),
          ),
        ),
        const SizedBox(height: 13),
        Obx(() {
          return Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color.fromRGBO(216, 218, 220, 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        controller.countryFlag ?? "", // Use default image if null
                        fit: BoxFit.fill,
                        height: 12,
                        width: 12,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        controller.countryCode ?? "",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: fontColor,
                          height: 1.21,
                        ),
                      ),
                    ],
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: const Color.fromRGBO(0, 0, 0, 0.7),
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      readOnly: true,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const UpdateNumberDetails(title: "Add Phone Number"));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        "Edit",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: themeColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
