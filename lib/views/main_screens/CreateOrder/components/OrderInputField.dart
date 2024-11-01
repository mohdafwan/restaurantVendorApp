import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';

class OrderInputField extends StatefulWidget {
  final String label;
  final String? hintText;
  final bool digitOnly;
  final bool allowNull;
  final String? preFill;
  final bool date;
  final bool time;
  final void Function(String) onChanged;

  const OrderInputField({
    super.key,
    required this.onChanged,
    required this.label,
    this.hintText,
    this.digitOnly = false,
    this.allowNull = false,
    this.preFill,
    this.date = false,
    this.time = false,
  });

  @override
  State<OrderInputField> createState() => _OrderInputFieldState();
}

class _OrderInputFieldState extends State<OrderInputField> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.preFill);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(OrderInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.preFill != widget.preFill) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        textController.text = widget.preFill ?? '';
      });
    }
  }

  Future<String?> selectDate() async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2100);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(253, 71, 18, 1),
            colorScheme: const ColorScheme.light(primary: Color.fromRGBO(253, 71, 18, 1)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child ?? Container(),
        );
      },
    );
    return picked != null ? "${picked.toLocal()}".split(' ')[0] : null;
  }

  Future<String?> selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(253, 71, 18, 1),
            colorScheme: const ColorScheme.light(primary: Color.fromRGBO(253, 71, 18, 1)),
            buttonTheme: const ButtonThemeData(
              buttonColor: Color.fromRGBO(253, 71, 18, 1),
              focusColor: Color.fromRGBO(253, 71, 18, 1)
            ),
          ),
          child: child ?? Container(),
        );
      },
    );

    String? result;
    if (context.mounted) {
      result = picked?.format(context);
    }
    return result;
  }

  void onTap() async {
    String? selectedValue;
    if (widget.date) {
      selectedValue = await selectDate();
    } else if (widget.time) {
      selectedValue = await selectTime();
    }

    if (selectedValue != null) {
      setState(() {
        textController.text = selectedValue!;
        widget.onChanged(selectedValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        if ((value == null || value.isEmpty) && !widget.allowNull) {
          return "Please Provide this Field";
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(30, 30, 30, 1),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromRGBO(244, 246, 250, 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      onTap: onTap,
                      cursorColor: fontColor,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      inputFormatters: widget.digitOnly
                          ? [FilteringTextInputFormatter.digitsOnly]
                          : [],
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: widget.digitOnly
                          ? TextInputType.number
                          : TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintText,
                        hintStyle: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                      onChanged: (text) {
                        widget.onChanged(text);
                      },
                      readOnly: widget.date || widget.time,
                    ),
                  ),
                ],
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  state.errorText ?? "",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
