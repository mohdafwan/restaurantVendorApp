import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:restaurant_vendor_app/controllers/splash_screen/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image(
                  image: AssetImage("assets/splashScreenImg/splashScreenBg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0),
                      Color.fromRGBO(252, 68, 14, 0.2),
                    ],
                    stops: [0, 0.6481],
                  ),
                ),
              ),
              
              CustomPaint(
                painter: SmallRingPainter(),
              ),
             
              CustomPaint(
                painter: LargerRingPainter(),
              ),
             
              Align(
                alignment: const Alignment(-1, 0.8),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: "Food is on the \n"),
                        TextSpan(
                          text: "way. Enjoy your \n",
                          style: TextStyle(color: Color(0xffFFC7A9)),
                        ),
                        TextSpan(text: "meal!"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class SmallRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final ringPaint = Paint()
      ..color = const Color.fromRGBO(255, 199, 169, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30; 

    canvas.drawArc(
      Rect.fromCircle(center: const Offset(380, 25), radius: 160.5),
      0, 
      3 * pi / 2,
      false,
      ringPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LargerRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final ringPaint = Paint()
      ..color = const Color.fromRGBO(255, 199, 169, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30; 

    canvas.drawArc(
      Rect.fromCircle(center: const Offset(300, 130), radius: 225.5),
      0, 
      3 * pi / 2,
      false,
      ringPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
