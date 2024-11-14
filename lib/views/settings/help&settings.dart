import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/views/settings/widgets/setting_tile.dart';

class HelpAndSettings extends StatelessWidget {
  const HelpAndSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Help & Settings',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: ColorPalette.primaryText,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 34),
          height: 24,
          width: 24,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            //splashColor: Colors.grey,
            child: Image.asset(ImageConstants.backArrow,
            height: 15, width: 18,),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
        child: Column(
          children: [
            SettingTile(title: 'Profile', icon: ImageConstants.profile,
            onTap: () => Get.find<DashboardController>().changeTabIndex(4),
            ),
            const SizedBox(height: 10,),
            SettingTile(title: 'View Tickets', icon: ImageConstants.ticket,
            onTap: () {
              
            },),
            const SizedBox(height: 10,),
            SettingTile(title: 'Rate Us', icon: ImageConstants.rateUs,
            onTap: () {
              
            },),
            const SizedBox(height: 10,),
            SettingTile(title: 'Help & Support', icon: ImageConstants.helpsupport,
            onTap: () => Get.toNamed('/help'),
            ),
          ],
        ),
      ),
    );
  }
}