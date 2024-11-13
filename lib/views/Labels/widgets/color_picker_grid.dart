import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';
import 'package:restaurant_vendor_app/views/Labels/widgets/popup_menu.dart';

class ColorPickerGrid extends StatefulWidget {
  final Function(Color) onColorSelected;
  
  const ColorPickerGrid({super.key,
   required this.onColorSelected,  
  
  });

  @override
  State<ColorPickerGrid> createState() => _ColorPickerGridState();
}

class _ColorPickerGridState extends State<ColorPickerGrid> {
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
  return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
              'Choose Color',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorPalette.greyText),
            ),
          const SizedBox(height: 12.0),
           Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                ),
                itemCount: colorOptions.length,
                itemBuilder: (context, index) {
                  final color = colorOptions[index];
                  final isSelected = selectedColor == color;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                      widget.onColorSelected(color);
                      //Navigator.pop(context); // Close the bottom sheet on color selection
                      // Handle color selection logic
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                  ),
                  child: isSelected
                      ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(ImageConstants.checkIcon,
                        height: 13.5,
                        width: 15,
                        fit: BoxFit.scaleDown,
                        ),
                      )
                      : null,
                ),
              );
            },
          ),
      ),
      ],
      ),
    );
  }
}