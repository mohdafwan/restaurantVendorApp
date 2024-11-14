import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_vendor_app/constants/ColorPalette.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';
import 'package:dio/dio.dart' as dio;

void showOperationalDaySheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return const OperatinalDaySheet();
    },
  );
}

class OperatinalDaySheet extends StatefulWidget {
  const OperatinalDaySheet({super.key});

  @override
  State<OperatinalDaySheet> createState() => _OperatinalDaySheetState();
}

class _OperatinalDaySheetState extends State<OperatinalDaySheet> {
  final restaurentController = Get.find<RestaurantController>();
  final dio.Dio _dio = dio.Dio();
  final currentDate = DateTime.now();
  late String todayDate;
  late String yesterdayDate;
  late ValueNotifier<DateTime> selectedDateNotifier;
  bool today = true;
  @override
  void initState() {
    todayDate = DateFormat('dd MMMM, yyyy - EEEE').format(currentDate);
    yesterdayDate =  DateFormat('dd MMMM, yyyy - EEEE').format(currentDate.subtract(const Duration(days: 1)));
    selectedDateNotifier = ValueNotifier<DateTime>(currentDate);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 198,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 11.56,
            right: 15,
            child: SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.close,
                  color: Color.fromRGBO(1, 1, 4, 1),
                  size: 16,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(227, 229, 231, 1),
                  shape: const CircleBorder(),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Confirm your operational day',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color.fromRGBO(30, 30, 30, 1)),
                ),
                ValueListenableBuilder<DateTime>(
                  valueListenable: selectedDateNotifier,
                  builder: (context, selectedDate, child) {
                    final formattedDate = selectedDate == currentDate ? todayDate : yesterdayDate;
                    return RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "$formattedDate\n${selectedDate == DateTime.now() ? "(Today)" : "(Yesterday)"} ",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: const Color.fromRGBO(30, 30, 30, 1),
                        ),
                        children: [
                          TextSpan(
                            text: "Edit",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: themeColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showConfirmDialog(context); 
                              },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 157,
                  child: Button(
                    onPressed: () {
                      restaurentController.updateRestaurantDetails(
                          status: true);
                      try {
                        _dio.put(
                          "$host/restaurant/${restaurentController.id}/",
                          data: {
                            "status": true,
                          },
                          options: dio.Options(
                            headers: {
                              'Content-Type': 'application/json',
                            },
                          ),
                        );
                      } catch (error) {
                        print(error);
                      }
                      Navigator.of(context).pop();
                    },
                    text: "Go Online",
                    color: const Color.fromRGBO(34, 168, 34, 1),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Are you sure you want to change the date?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: const Color.fromRGBO(20, 28, 36, 1),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Button(
                      width: 133,
                      height: 35,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: const Color.fromRGBO(247, 248, 249, 1),
                      textColor: const Color.fromRGBO(48, 48, 48, 1),
                      fontSize: 12,
                      text: "Cancel",
                    ),
                    const SizedBox(width: 43),
                    Button(
                      width: 133,
                      height: 35,
                      onPressed: () {
                        Navigator.of(context).pop();
                        showOptionDialog(context);
                      },
                      fontSize: 12,
                      text: "Confirm",
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Select Your Operational Day',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: const Color.fromRGBO(20, 28, 36, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    OptionButton(
                      text: "$yesterdayDate\n(Yesterday)",
                      selected: !today, 
                      onPressed: () {
                        setState(() {
                          selectedDateNotifier.value = currentDate.subtract(const Duration(days: 1));
                          today = !today;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    OptionButton(
                      text: "$todayDate\n(Today)",
                      selected: today, 
                      onPressed: () {
                        setState(() {
                          selectedDateNotifier.value = currentDate;
                          today = !today;
                        });
                      },
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Button(
                          width: 133,
                          height: 35,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: const Color.fromRGBO(247, 248, 249, 1),
                          textColor: const Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 12,
                          text: "Cancel",
                        ),
                        const SizedBox(width: 43),
                        Button(
                          width: 133,
                          height: 35,
                          onPressed: () {
                            // handle change
                            Navigator.of(context).pop();
                          },
                          fontSize: 12,
                          text: "Confirm",
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget OptionButton(
      {required String text,
      required bool selected,
      required Function() onPressed}) {
    return SizedBox(
      width: 317,
      height: 65,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromRGBO(30, 30, 30, 1),
          backgroundColor: selected
              ? const Color.fromRGBO(255, 244, 237, 1)
              : Colors.transparent,
          side: selected
              ? const BorderSide(
                  color: Color.fromRGBO(253, 71, 18, 1),
                  width: 1,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 8),
              const Icon(
                Icons.check_circle_rounded,
                size: 16,
                color: Color.fromRGBO(253, 71, 18, 1),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
