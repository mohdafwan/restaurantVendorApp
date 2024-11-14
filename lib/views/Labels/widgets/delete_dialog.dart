import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/text_constants.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  
  const DeleteDialog({super.key, 
  required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorPalette.backgroundGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextConstants.deleteTitleLabel,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorPalette.primaryText
              ),
            ),
            const SizedBox(height: 10),
            Text(
              TextConstants.deleteLabel,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: ColorPalette.deleteText
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No',
                  style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.saveText),),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: onConfirm,
                  child: Text('Yes',
                   style: GoogleFonts.inter(fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.saveText),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}