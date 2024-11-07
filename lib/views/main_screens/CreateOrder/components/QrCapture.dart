import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:restaurant_vendor_app/views/main_screens/CreateOrder/CreateOrder.dart';

class QrCapture extends StatefulWidget {
  const QrCapture({super.key});
  @override
  State<QrCapture> createState() => _QrCaptureState();
}

class _QrCaptureState extends State<QrCapture> {
  final qrKey = GlobalKey();
  late QRViewController qrController;

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await qrController.pauseCamera();
    }
    qrController.resumeCamera();
  }

  @override
  void dispose() {
    qrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: (controller) {
          setState(() {
            qrController = controller;
          });
          qrController.scannedDataStream.listen((qrCode) {
            Get.off(() => CreateOrder(
                  encryptedString: qrCode.code,
                  uid: true,
                )); // go to create order page
          });
        },
        overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
