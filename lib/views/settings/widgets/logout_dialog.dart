import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/text_constants.dart';

class LogoutDialog {
  static void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          backgroundColor: ColorPalette.labelBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TextConstants.logoutText,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: ColorPalette.primaryText,
                    fontWeight: FontWeight.w600),
                ),
                //SizedBox(height: 20),
                const Divider(
                  color: ColorPalette.dividerColor,
                  thickness: 0.5,
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // Add logout from current device logic here
                  },
                  child: Text(
                    TextConstants.currentDevice,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: themeColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: ColorPalette.dividerColor,
                  thickness: 0.5,
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // Add logout from all devices logic here
                  },
                  child: Text(
                    TextConstants.allDevice,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: ColorPalette.allDevice,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: ColorPalette.dividerColor,
                  thickness: 0.8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    TextConstants.cancel,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: ColorPalette.saveText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
