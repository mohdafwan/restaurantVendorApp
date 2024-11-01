import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/controllers/OrderController/OrderController.dart';

class OrderUniqueIdField extends StatefulWidget {
  final String? preFill;
  const OrderUniqueIdField({super.key, this.preFill});

  @override
  State<OrderUniqueIdField> createState() => _OrderUniqueIdFieldState();
}

class _OrderUniqueIdFieldState extends State<OrderUniqueIdField> {
  final orderController = Get.find<OrderController>();
  late TextEditingController uidTextController;
  @override
  void initState() {
    uidTextController = TextEditingController(text: widget.preFill);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FormField<String>(validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please Provide this Field";
      }
      return null;
    }, builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unique Id',
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
                    controller: uidTextController,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    onChanged: (text) {
                      orderController.uid = int.parse(text);
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter uid Here",
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
                    if(orderController.uid != null){
                      orderController.find(uid: orderController.uid);
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
