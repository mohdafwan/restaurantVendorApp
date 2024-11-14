import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';
import 'package:restaurant_vendor_app/constants/text_constants.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/views/Labels/labels.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/components/total_order_card.dart';
import 'package:restaurant_vendor_app/views/settings/help&settings.dart';
import 'package:restaurant_vendor_app/views/settings/help_page.dart';
import 'package:restaurant_vendor_app/views/settings/widgets/logout_dialog.dart';
import 'package:restaurant_vendor_app/views/settings/widgets/setting_tile.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Settings',
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
              Get.find<DashboardController>().changeTabIndex(0);
            },
            //splashColor: Colors.grey,
            child: Image.asset(ImageConstants.backArrow),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               _buildPremiumCard(),
               const SizedBox(height: 20),
               OrderSummaryCard(),

               const SizedBox(height: 20),
               Padding(
                 padding: const EdgeInsets.only(top:8.0, right: 20, bottom: 8, left: 20),
                 child: SettingTile(
                          title: TextConstants.label,
                          icon: ImageConstants.label,
                          onTap: (){
                            const Labels();
                          }
                        ),
               ),
                      Padding(
                         padding: const EdgeInsets.only(top:8.0, right: 20, bottom: 8, left: 20),
                        child: SettingTile(
                          title: TextConstants.help,
                          icon: ImageConstants.helpSettings,
                          onTap: () => const HelpAndSettings(),
                        ),
                      ),
                      Padding(
                         padding: const EdgeInsets.only(top:8.0, right: 20, bottom: 8, left: 20),
                        child: SettingTile(
                          title: TextConstants.support,
                          icon: ImageConstants.supportChat,
                          onTap: () => const HelpPage(),
                        ),
                      ),
                      Padding(
                      padding: const EdgeInsets.only(top: 80,),
                      child: Center(
                      child: TextButton(
                      onPressed: () => LogoutDialog.showLogoutDialog(context),
                      child: Text(
                      "Log out",
                     style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.greyText.withOpacity(0.5)
                    ),
                  ),
              ),
            ),
          ),
            
            ],
          ),
        ),
      )
    ); 
 }
}

  Widget _buildPremiumCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 15),
      child: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorPalette.backgroundGrey,
          borderRadius: BorderRadius.circular(8),
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TextConstants.premium,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: ColorPalette.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  TextConstants.plan,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.greyText.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            Button(onPressed: () {}, text: 'Upgrade', width: 78,
            height: 30,
            fontSize: 12,),
          ],
        ),
      ),
    );
 }

  