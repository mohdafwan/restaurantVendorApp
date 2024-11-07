import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/ColorPalette.dart';
import 'package:restaurant_vendor_app/controllers/OrderController/OrderController.dart';
import 'package:restaurant_vendor_app/controllers/PhoneNumberController/PhoneNumberController.dart';

class OrderPhoneField extends StatefulWidget {
  const OrderPhoneField({super.key});

  @override
  State<OrderPhoneField> createState() => _OrderPhoneFieldState();
}

class _OrderPhoneFieldState extends State<OrderPhoneField> {
  final controller = Get.put(PhoneNumberController());
  final phoneController = TextEditingController();
  final orderController = Get.find<OrderController>();
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: (value) => controller.validate(),
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              'Phone Number',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(30, 30, 30, 1),
              ),
            ),
            const SizedBox(height: 15),
              Container(
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color.fromRGBO(244, 246, 250, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.selectedCountryCode,
                            icon: const Icon(Icons.keyboard_arrow_down_outlined,
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: fontColor,
                                        height: 1.21,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.setSelectedCountryCode(newValue);
                              }
                            },
                          ),
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: const Color.fromRGBO(0, 0, 0, 0.7),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (text) {
                            controller.updatePhoneNumber(text);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if(controller.validate() == null){
                            orderController.find(phone: controller.getE164FormattedPhoneNumber());
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 16,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          maxWidth: 40,
                          maxHeight: 40,
                        ),
                        style: IconButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: const Color.fromRGBO(255, 244, 237, 0.5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
