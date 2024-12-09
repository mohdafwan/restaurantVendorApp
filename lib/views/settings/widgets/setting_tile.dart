import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String? icon;
  final Icon? materialIcon;
  final VoidCallback? onTap;

  const SettingTile({
    super.key,
    required this.title,
     this.icon,
    this.materialIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorPalette.circleicon,
        ),
        child: materialIcon ?? Image.asset(icon!, height: 24, width: 24,
        fit: BoxFit.cover,),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: 
        Image.asset(ImageConstants.fwdArrow,
        height: 24,
        width: 24,),
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
    );
  }
}
