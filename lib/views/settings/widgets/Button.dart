import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/ColorPalette.dart';


class Button extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool disable;
  final Color? color;
  final Color? disableColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final Color? disableTextColor;
  final double? width;
  final double? height;
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.disable = false, 
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.disableTextColor,
    this.disableColor,
    this.width,
    this.height,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 44,
      child: TextButton(
        onPressed: widget.disable ? null : widget.onPressed,
        onHover: (value) {},
        style: TextButton.styleFrom(
          disabledBackgroundColor: widget.disableColor ??const Color.fromRGBO(247, 249, 250, 1),
          disabledForegroundColor: widget.disableTextColor ?? fontColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: widget.color ?? themeColor,
          foregroundColor: widget.textColor ?? Colors.white,
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.inter(
            fontWeight: widget.fontWeight ?? FontWeight.w700,
            fontSize: widget.fontSize ?? 16,
            height: 1.21,
          ),
        ),
      ),
    );
  }
}