import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/controllers/SignUpController/SignUpController.dart';

class DateField extends StatefulWidget {
  const DateField({super.key});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late TextEditingController dateController;
  final controller = Get.find<SignUpController>();

  @override
  void initState() {
    dateController = TextEditingController();
    dateController.text = controller.dateOfBirth ?? "";
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) => controller.validate(value: controller.dateOfBirth, message: "Please provide date of birth"),
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date of Birth",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(32, 37, 56, 1),
              ),
            ),
            const SizedBox(height: 13),
            Container(
              width: double.infinity,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: state.hasError ? Colors.red : const Color.fromRGBO(216, 218, 220, 1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onTap: () async {
                        await controller.selectDateOfBirth(context);
                        setState(() {
                          dateController.text = controller.signUpModel.value.dateOfBirth ?? '';
                          state.didChange(dateController.text); // Update FormField state
                        });
                      },
                      controller: dateController,
                      cursorColor: fontColor,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Select Date",
                        hintStyle: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(128, 128, 128, 1),
                        ),
                        border: InputBorder.none,
                        // contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      readOnly: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/signUpAssets/Date.svg',
                        width: 24,
                        height: 24,
                      ),
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
