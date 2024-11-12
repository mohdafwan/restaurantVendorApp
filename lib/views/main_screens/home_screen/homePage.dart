import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/components/OperationalDaySheet.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final restaurentController = Get.find<RestaurantController>();
  final searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 30,
        title: Text(
          'Orders',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: const Color.fromRGBO(30, 30, 30, 1)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Obx(() {
              return FlutterSwitch(
                width: 74,
                height: 32,
                valueFontSize: 12,
                toggleSize: 22.0,
                activeText: "Online",
                inactiveText: "Offline",
                activeColor: const Color.fromRGBO(34, 168, 34, 1),
                inactiveColor: const Color.fromRGBO(208, 217, 231, 1),
                activeTextColor: Colors.white,
                inactiveTextColor: Colors.white,
                activeTextFontWeight: FontWeight.w400,
                inactiveTextFontWeight: FontWeight.w400,
                value: restaurentController.status!,
                borderRadius: 100.0,
                padding: 4.0,
                showOnOff: true,
                onToggle: (val) {
                  if (val) {
                    showOperationalDaySheet(context);
                  }
                },
              );
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 13),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: const Color.fromRGBO(229, 233, 235, 1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        size: 16,
                        color: Color.fromRGBO(148, 146, 146, 1),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchTextController,
                          cursorColor: const Color.fromRGBO(148, 146, 146, 1),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 9,
                            ),
                          ),
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (text) {},
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 54,
                ),
                SvgPicture.asset(
                  'assets/homeImages/OrderNotPlaced.svg',
                ),
                const SizedBox(
                  height: 22.35,
                ),
                Text(
                  restaurentController.status! ?'No Orders Yet.':'You are Offline',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color.fromRGBO(30, 30, 30, 1)),
                ),
                const SizedBox(
                  height: 16,
                ),
                Button(onPressed: () {}, text: "View History"),
                const SizedBox(height: 54)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
