// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
import 'package:restaurant_vendor_app/models/label/label.model.dart';
import 'package:restaurant_vendor_app/views/Labels/change_color_edit_label.dart';
import 'package:restaurant_vendor_app/views/Labels/widgets/color_picker_grid.dart';
import 'package:restaurant_vendor_app/views/Labels/widgets/delete_dialog.dart';

// Define your color options here
const List<Color> colorOptions = [
  Colors.red,
  Colors.blue,
  Colors.orange,
  Colors.cyan,
  Colors.brown,
  Colors.green,
  Colors.yellow,
  Colors.deepOrange,
  Colors.pink,
  Colors.purple,
  Colors.grey,
  Colors.indigo,
  Colors.teal,
  Colors.black,
  Colors.lime,
  Colors.amber,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.blueGrey
];

final restaurantController = Get.find<RestaurantController>();
// Function to show the popup menu
void showPopupMenu(BuildContext context, 
Function(Color) onColorSelected, 
Label label, int index) {
  
  showMenu<String>(
    elevation: 2,
    //shadowColor: Color(0xff101828).withOpacity(0.06),
    color: ColorPalette.backgroundGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    
    // menuPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    context: context,
    position: const RelativeRect.fromLTRB(174, 105, 32, 0), // Adjust position as needed
    items: [
       PopupMenuItem<String>(
        padding: const EdgeInsets.only(left:10, top: 10, bottom: 10),
        height: 18,
        value: 'Edit Label',
        child: Text('Edit Label',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorPalette.greyText,
        ),),
      ),
       PopupMenuItem<String>(
        padding: const EdgeInsets.only(left:10, top: 5, bottom: 5),
        height: 18,
        value: 'Choose Color',
        child: Text('Choose Color',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorPalette.greyText,
        ),),
      ),
      PopupMenuItem<String>(
        padding: const EdgeInsets.only(left:10, top: 8, bottom: 10),
        height: 18,
        value: 'Delete Label',
        child: Text('Delete Label',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorPalette.greyText,
        ),),
      ),
    ],
  ).then((value) {
    if (value == 'Choose Color') {
      showColorPickerBottomSheet(context, onColorSelected);
    }
    else if (value == 'Edit Label') {
      Navigator.push(context,
      MaterialPageRoute(
      builder: (context)=> ChangeColorEditLabel(
        label: label,
        index: index,
      )
      ),
      );
    }
    else if (value == 'Delete Label') {
      showDeleteDialog(context, label.label, index);
    }
  });
}

// Function to show the color picker as a bottom sheet
void showColorPickerBottomSheet(BuildContext context, Function(Color) onColorSelected) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorPalette.backgroundGrey,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30)
      ),
    ),
    builder: (BuildContext context) {
      return ColorPickerGrid(onColorSelected: onColorSelected);
    },
  );
}

// Function to show the delete confirmation dialog
void showDeleteDialog(BuildContext context, String? labelName, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteDialog(
        onConfirm: () {
          // Delete the label (implement your delete logic here)
          print("Label deleted"); // Replace with actual delete logic
          final newList =  restaurantController.labels;
          newList.removeAt(index);
          restaurantController.updateLabels(newList);
          
          Navigator.of(context).pop();
        },
      );
    },
  );
}


