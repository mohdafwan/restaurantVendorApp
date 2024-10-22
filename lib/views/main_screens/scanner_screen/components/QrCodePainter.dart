import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePainter extends CustomPainter {
  final String data;
  final Color backgroundColor;

  QrCodePainter({required this.data, this.backgroundColor = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the background
    final paint = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Create the QR code
    final qrCode = QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: false,
    );

    // Paint the QR code on top of the background
    qrCode.paint(canvas, size);
  }

  @override
  bool shouldRepaint(QrCodePainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.backgroundColor != backgroundColor;
  }
}
