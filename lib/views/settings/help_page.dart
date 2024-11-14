import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';
import 'package:restaurant_vendor_app/constants/text_constants.dart';
import 'package:restaurant_vendor_app/views/settings/widgets/help_tile.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Help',
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
        padding: const EdgeInsets.only(left: 24.0, top: 20,),
        child: Column(
          children: [
            HelpTile(title: TextConstants.aboutUs,
            onTap: () {
              
            },),
            const SizedBox(height: 20,),
            HelpTile(title: TextConstants.policy,
            onTap: () {
              
            },),
            const SizedBox(height: 20,),
            HelpTile(title: TextConstants.conditions,
            onTap: () {
              
            },),
            
          ],
        ),
      )
    );
  }
}