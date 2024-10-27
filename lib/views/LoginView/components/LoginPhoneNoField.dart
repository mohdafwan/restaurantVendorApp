import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/controllers/LoginController/LoginController.dart';

class LoginPhoneNoField extends StatefulWidget {
  const LoginPhoneNoField({super.key});

  @override
  State<LoginPhoneNoField> createState() => _LoginPhoneNoFieldState();
}

class _LoginPhoneNoFieldState extends State<LoginPhoneNoField> {
  final controller = Get.find<LoginController>();
  late TextEditingController phoneNumberInputController;
  final GlobalKey<FormFieldState<String>> _formFieldKey =
      GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    phoneNumberInputController = TextEditingController();
    phoneNumberInputController.addListener((){
      setState(() { });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormField<String>(
          key: _formFieldKey,
          validator: (value) => controller.validatePhoneNumber(),
          builder: (state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone number',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: const Color.fromRGBO(32, 37, 56, 1)
                  ),
                ),
                const SizedBox(height: 13,),
                Container(
                  height: 38,
                  width: 315,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: const Color.fromRGBO(216, 218, 220, 1)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        DropdownButtonHideUnderline(
                          child: Obx(() => DropdownButton<String>(
                                value: controller.selectedCountryCode,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black),
                                dropdownColor: backgroundColor,
                                borderRadius: BorderRadius.circular(4),
                                items: controller.countries.map((country) {
                                  return DropdownMenuItem<String>(
                                    value: country['code'],
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          country['icon']!,
                                          fit: BoxFit.fill,
                                          height: 12,
                                          width: 12,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          country['code']!,
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: fontColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.setSelectedCountryCode(newValue!);
                                },
                              )),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: TextField(
                            controller: phoneNumberInputController,
                            cursorColor: fontColor,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              PhoneNumberInputFormatter()
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (number) {
                              controller.updatePhoneNumber(number);
                            },
                            onEditingComplete: () {
                              _formFieldKey.currentState!.validate();
                            },
                          ),
                        ),
                        if(phoneNumberInputController.text.isNotEmpty)
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: (){
                              phoneNumberInputController.clear();
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(255, 244, 237, 1),
                              shape: const CircleBorder()
                            ),
                            icon: const Icon(
                              Icons.close,
                              size: 16,
                              color: Color.fromRGBO(68, 82, 117, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      state.errorText ?? "",
                      style: GoogleFonts.inter(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}


class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    final digitsOnly = text.replaceAll(' ', '');

    if (digitsOnly.length > 10) {
      return oldValue;
    }
    String formattedText;
    if (digitsOnly.length > 5) {
      formattedText = '${digitsOnly.substring(0, 5)} ${digitsOnly.substring(5)}';
    } else {
      formattedText = digitsOnly;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

