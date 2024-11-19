import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';

class LabelTile extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback? onTap;

  const LabelTile({
    super.key,
    required this.color,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Image.asset(ImageConstants.arrowboard, 
        height: 14, width: 19,
        fit: BoxFit.fitWidth,),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color:ColorPalette.primaryText,
        ),
      ),
      trailing: 
      Image.asset(ImageConstants.equal,
      height: 6, width: 16,
      fit: BoxFit.fitWidth,),
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
    );
  }
}
