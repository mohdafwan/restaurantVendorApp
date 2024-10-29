import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Profile Verification',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: const Color.fromRGBO(30, 30, 30, 1)
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 61,
            ),
            const Icon(
              Icons.access_time_filled_rounded,
              size: 50,
              color: Color.fromRGBO(34, 168, 34, 1),
            ),
            const SizedBox(height: 47,),
            Text(
              'Your account is being verified',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: const Color.fromRGBO(30, 30, 30, 1)
              ),
            ),
            const SizedBox(height: 17,),
            Text(
              'This usually takes 24 hours, but in some\ninstances, it may take up to two weeks. We will\ninform you once the verification is finished.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: const Color.fromRGBO(148, 146, 146, 1)
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Container(
              width: 176,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Button(onPressed: () {
                // handle contact us
              }, text: 'Contact us'),
            ),
            const SizedBox(height: 24,),
            SizedBox(
              width: 113,
              height: 35,
              child: TextButton(
                onPressed: () {
                  Get.find<AuthMethods>().signOut();
                },
                child: Text(
                  'Log Out',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(48, 48, 48, 1)
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}