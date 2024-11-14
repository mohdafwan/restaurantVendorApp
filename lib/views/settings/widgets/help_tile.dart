import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';

class HelpTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const HelpTile({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 370,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
        Image.asset(ImageConstants.fwdArrow,
        height:24,
        width:24,
        fit: BoxFit.cover
        ),
      
      ],
      )
    );
    
  }
}