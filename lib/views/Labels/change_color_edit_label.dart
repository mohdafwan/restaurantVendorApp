import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';
import 'package:restaurant_vendor_app/views/Labels/widgets/popup_menu.dart';

import '../../models/label/label.model.dart';

class ChangeColorEditLabel extends StatefulWidget {
  final Label label;
  const ChangeColorEditLabel({super.key,
  required this.label});

  @override
  State<ChangeColorEditLabel> createState() => _ChangeColorEditLabelState();
}


class _ChangeColorEditLabelState extends State<ChangeColorEditLabel> {
  late TextEditingController textEditingController;
  Color selectedColor = Colors.white;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.label.label);
    selectedColor = widget.label.color; // Initialize with the label's color
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Edit Label',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorPalette.primaryText,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 30),
          height: 24,
          width: 24,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              ImageConstants.backArrow,
              height: 15,
              width: 18,
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            height: 24,
            width: 24,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  ImageConstants.threedots,
                  height: 13.5,
                  width: 1.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                     color: selectedColor, // U
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(ImageConstants.colorPalette,
                      height: 21.01,
                      width: 21.01,
                      fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width:5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right:45.0),
                    child: TextField(
                      cursorColor: ColorPalette.greyText,
                      decoration: InputDecoration(
                        focusColor: ColorPalette.greyText,
                        hintText: 'Edit Labels',
                        hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.primaryText,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color:ColorPalette.greyText)
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: ColorPalette.greyText,
                            strokeAlign: BorderSide.strokeAlignInside
                          )
                        ),
                      ),         
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: themeColor),
                    ),
                  ),
                  const SizedBox(width: 30,),
                  TextButton(
                    onPressed: () {
                      String updatedLabelName = textEditingController.text.trim();
                      //Color updatedColor = selectedColor;

                      final updatedLabel = Label(
                        label: updatedLabelName,
                        color: updatedColor.value,
                      ); 
                       // Create a new list with the updated label
                            final updatedLabels = restaurantController.labels.map((label) {
                              if (label.label == widget.label.label) {
                                // Replace the old label with the updated label
                                return updatedLabel;
                              }
                              return label;
                            }).toList();

                            // Update the labels in the controller
                            restaurantController.updateLabels(updatedLabels);

                            // Optionally, close the dialog or clear the text field after saving
                            Navigator.pop(context); // Close the modal/dialog
                  },
                    child: Text("Save",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: ColorPalette.saveText,
                    ),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}