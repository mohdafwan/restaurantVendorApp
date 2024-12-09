import 'package:flutter/material.dart';

import '../../../constants/color_palette.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: ColorPalette.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorPalette.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Pricing Plans",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.primaryColor,
                  fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Plans for all sizes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorPalette.darkPrimaryColor,
                fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "Simple, transparent pricing that grows with you. Try any plan free for 30 days.",
            style: TextStyle(color: Colors.black54, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          RichText(
            text: const TextSpan(
              text: "Annual pricing ",
              style: TextStyle(color: ColorPalette.darkPrimaryColor),
              children: [
                TextSpan(
                  text: "(save 20%)",
                  style: TextStyle(color: ColorPalette.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
