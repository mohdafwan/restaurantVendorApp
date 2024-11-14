import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';
import 'package:restaurant_vendor_app/views/Labels/widgets/popup_menu.dart';

class FoodLabel extends StatefulWidget {
  const FoodLabel({super.key});

  @override
  State<FoodLabel> createState() => _FoodLabelState();
}

class _FoodLabelState extends State<FoodLabel> {
  Color selectedColor = Colors.white;

  void _updateColor(Color color){
    setState(() {
      selectedColor = color;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Row(
          children: [
          Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorPalette.circleicon,
        ),
        child: Image.asset(
          ImageConstants.arrowboard, 
          height: 14, 
          width: 19,),
      ),
      const SizedBox(width: 5),
            Text(
              'Food',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorPalette.primaryText,
              ),
              
            ),
          ],
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
            child: Image.asset(
            ImageConstants.backArrow,
            height: 15, width: 18,),
          ),
        ),
        actions: [
          Container(
          margin: const EdgeInsets.only(right: 20),
          height: 24,
          width: 24,
          child: InkWell(
            onTap: () {
              showPopupMenu(context, _updateColor);
            },
            //splashColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(ImageConstants.threedots,
              height: 13.5, width: 1.5,
              fit: BoxFit.cover,
              ),
            ),
          ),
          )
        ],
      ),
    );
  }
}