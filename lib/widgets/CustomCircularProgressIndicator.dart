import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 244, 237, 1),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(255, 244, 237, 1),
          color: Color.fromRGBO(252, 68, 14, 1),
          strokeWidth: 3,
        ),
      ),
    );
  }
}
