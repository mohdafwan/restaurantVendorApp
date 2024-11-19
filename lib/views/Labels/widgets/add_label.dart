import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';


class AddLabel extends StatefulWidget {
  final String title;
  final String hintText;
  final String initialText;
  final VoidCallback onCancel;
  final Function(String) onSave;
  final TextEditingController controller;

  const AddLabel({
    super.key, 
    required this.title, 
    required this.hintText, 
    this.initialText = '', 
    required this.onCancel, 
    required this.onSave, 
    required this.controller
    });

  @override
  State<AddLabel> createState() => _AddLabelState();
}

class _AddLabelState extends State<AddLabel> {
  bool isSaveEnabled = false;
  

  


  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialText;
    widget.controller.addListener(_checkTextField);
    _checkTextField(); // Initial check
  }


  @override
  void dispose() {
    widget.controller.removeListener(_checkTextField);
    super.dispose();
  }

  void _checkTextField() {
    setState(() {
      isSaveEnabled = widget.controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorPalette.labelBg,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      shadowColor: Colors.black26,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.primaryText,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 230, 220, 247),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(ImageConstants.arrowboard,
                      height: 14,
                      width: 19,
                      fit: BoxFit.contain,
                      ),
                    )
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: widget.controller,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.hintTextColor,
                          ),
                          border: const UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.onCancel,
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: themeColor)
                    ),
                  ),
                  const SizedBox(width:20),
                  TextButton(
                    onPressed: isSaveEnabled
                        ? () => widget.onSave(widget.controller.text)
                        : null, // Disable the button if text is empty
                    child: Text('Save',
                    style: GoogleFonts.inter(fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isSaveEnabled ? ColorPalette.saveLabelHiglight :ColorPalette.saveLabelText,)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}