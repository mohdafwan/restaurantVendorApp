import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final dashController = Get.find<DashboardController>();
  FocusNode focusNode = FocusNode();
  bool showOptions = false;

  @override
  void initState() {
    focusNode.addListener(() {
      if (showOptions) {
        setState(() {
          showOptions = focusNode.hasFocus;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // option container
        if(showOptions)
        Positioned(
          bottom: 134,
          right: MediaQuery.of(context).size.width / 2 - 119.5,
          child: OptionContainer(),
        ),
        // shadow
        Positioned(
          top: -30,
          left: MediaQuery.of(context).size.width / 2 - 40,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                width: 4,
                color: Colors.white,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(1, 0),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 85,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(1, 0),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // dashController.changeTabIndex(1);
                },
                child: Container(
                  padding:
                      const EdgeInsets.all(16.0),
                  color: Colors
                      .transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: dashController.currentTab == 1
                            ? SvgPicture.asset(
                                'assets/images/cart_selected.svg',
                                fit: BoxFit.contain,
                              )
                            : SvgPicture.asset(
                                'assets/images/cart.svg',
                                fit: BoxFit.contain,
                              ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Order',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: dashController.currentTab == 1
                              ? const Color.fromRGBO(253, 71, 18, 1)
                              : const Color.fromRGBO(72, 76, 82, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              GestureDetector(
                onTap: () {
                  // dashController.changeTabIndex(2);
                },
                child: Container(
                   padding:
                      const EdgeInsets.all(16.0),
                  color: Colors
                      .transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: dashController.currentTab == 2
                            ? SvgPicture.asset(
                                'assets/images/person_selected.svg',
                                fit: BoxFit.contain,
                              )
                            : SvgPicture.asset(
                                'assets/images/person.svg',
                                fit: BoxFit.contain,
                              ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Profile',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: dashController.currentTab == 2
                                ? const Color.fromRGBO(253, 71, 18, 1)
                                : const Color.fromRGBO(72, 76, 82, 1)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // center button
        Positioned(
          top: -30,
          left: MediaQuery.of(context).size.width / 2 - 40,
          child: GestureDetector(
            onTap: () {
              setState(() {
                focusNode.requestFocus();
                showOptions = !showOptions;
              });
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(253, 71, 18, 1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget OptionContainer() {
    return Focus(
      focusNode: focusNode,
      child: Container(
        width: 239,
        height: 252,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(100, 52, 248, 0.15),
              offset: Offset(1.5, 2.99), 
              blurRadius: 8.98,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Option(
              onTap: () {},
              svg: 'assets/images/qrCode.svg',
              label: 'QR Code',
            ),
            const SizedBox(height: 16,),
            Option(
              onTap: () {},
              svg: 'assets/images/card.svg',
              label: 'Unique ID',
            ),
            const SizedBox(height: 16,),
            Option(
              onTap: () {},
              svg: 'assets/images/phone.svg',
              label: 'Mobile Number',
            ),
            const SizedBox(height: 16,),
            Option(
              onTap: () {},
              svg: 'assets/images/mail.svg',
              label: 'Mail id',
            ),
          ],
        ),
      ),
    );
  }
  Widget Option({required void Function() onTap,required String svg,required String label}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color.fromRGBO(247, 249, 250, 1)),
            child: Center(
                child: SvgPicture.asset(
              svg,
              width: 16,
              height: 16,
            )),
          ),
          const SizedBox(
            width: 23,
          ),
          Text(
            label,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: const Color.fromRGBO(30, 30, 30, 1)),
          )
        ],
      ),
    );
  }
}
