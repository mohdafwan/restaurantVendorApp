import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/controllers/EmailController/EmailController.dart';
import 'package:restaurant_vendor_app/controllers/OrderController/OrderController.dart';

class OrderEmailField extends StatefulWidget {
  const OrderEmailField({super.key});

  @override
  State<OrderEmailField> createState() => _OrderEmailFieldState();
}

class _OrderEmailFieldState extends State<OrderEmailField> {
  final controller = Get.put(EmailController());
  final orderController = Get.find<OrderController>();
  final mailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FormField<String>(validator: (value) {
      if (controller.validate()) {
        return null;
      }
      return "Invalid Email";
    }, builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email Address',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: mailTextController,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    onChanged: (text) {
                      controller.updateEmailAddress(text);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Email Here",
                      hintStyle: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(128, 128, 128, 1),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if(controller.validate()){
                      orderController.find(mail: controller.emailAddress);
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
        ],
      );
    });
  }
}
