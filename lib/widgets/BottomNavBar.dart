import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/views/main_screens/CreateOrder/CreateOrder.dart';
import 'package:restaurant_vendor_app/views/main_screens/CreateOrder/components/QrCapture.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final dashController = Get.find<DashboardController>();
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 134,
        right: MediaQuery.of(context).size.width / 2 - 119.5,
        child: TapRegion(
          onTapOutside: (_){
            _removeOverlay();
          },
          child: OptionContainer(close: _removeOverlay),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleOverlay(BuildContext context) {
    if (_overlayEntry == null) {
      _showOverlay(context);
    } else {
      _removeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
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
                child: _navItem(
                  svg: dashController.currentTab == 1
                      ? 'assets/images/cart_selected.svg'
                      : 'assets/images/cart.svg',
                  label: 'Order',
                  isSelected: dashController.currentTab == 1,
                ),
              ),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: () {
                  // dashController.changeTabIndex(2);
                },
                child: _navItem(
                  svg: dashController.currentTab == 2
                      ? 'assets/images/person_selected.svg'
                      : 'assets/images/person.svg',
                  label: 'Profile',
                  isSelected: dashController.currentTab == 2,
                ),
              ),
            ],
          ),
        ),
        // center button
        Positioned(
          top: -30,
          left: MediaQuery.of(context).size.width / 2 - 40,
          child: GestureDetector(
            onTap: () => _toggleOverlay(context),
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

  Widget _navItem({required String svg, required String label, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              svg,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: isSelected
                  ? const Color.fromRGBO(253, 71, 18, 1)
                  : const Color.fromRGBO(72, 76, 82, 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget OptionContainer({required void Function() close}) {
    return Container(
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
            onTap: () {
              Get.to(()=>const QrCapture());
              close();
            },
            svg: 'assets/images/qrCode.svg',
            label: 'QR Code',
          ),
          const SizedBox(height: 16),
          Option(
            onTap: () {
              Get.to(()=>const CreateOrder(uid: true));
              close();
            },
            svg: 'assets/images/card.svg',
            label: 'Unique ID',
          ),
          const SizedBox(height: 16),
          Option(
            onTap: () {
              Get.to(()=>const CreateOrder(phone: true));
              close();
            },
            svg: 'assets/images/phone.svg',
            label: 'Mobile Number',
          ),
          const SizedBox(height: 16),
          Option(
            onTap: () {
              Get.to(()=>const CreateOrder(mail: true));
              close();
            },
            svg: 'assets/images/mail.svg',
            label: 'Mail id',
          ),
        ],
      ),
    );
  }

  Widget Option({required void Function() onTap, required String svg, required String label}) {
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
              shape: BoxShape.circle,
              color: Color.fromRGBO(247, 249, 250, 1),
            ),
            child: Center(
              child: SvgPicture.asset(
                svg,
                width: 16,
                height: 16,
              ),
            ),
          ),
          const SizedBox(width: 23),
          Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: const Color.fromRGBO(30, 30, 30, 1),
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}
