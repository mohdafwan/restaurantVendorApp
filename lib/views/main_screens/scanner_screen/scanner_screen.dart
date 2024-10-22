import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_vendor_app/utils/toastMessage.dart';
import 'package:restaurant_vendor_app/views/main_screens/scanner_screen/components/QrCodePainter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../controllers/QrCodeController/qr_code_controller.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ScannerScreen extends StatelessWidget {
  final QRCodeController qrCodeController = Get.put(QRCodeController());

  ScannerScreen({super.key}) {
    qrCodeController.fetchCurrentUserDetails();
  }

  final String apiKey = "your-api-key-here"; // Your API key for encryption

  // Encrypt the user data
  String encryptData(String data, String apiKey) {
    final key =
        encrypt.Key.fromUtf8(apiKey.padRight(32, '0')); // Ensure 32 chars
    final iv = encrypt.IV.fromLength(16); // 16-byte initialization vector
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64; // Return base64 encoded encrypted data
  }

  // Generate QR code data with encrypted user info
  String generateQrCodeData(
      String name, String email, String phone, String apiKey) {
    final data = jsonEncode({
      'name': name,
      'email': email,
      'phone': phone,
    });
    return encryptData(data, apiKey);
  }

  // Save the QR code to gallery
  Future<void> _saveQrCodeToGallery(GlobalKey key, BuildContext context) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Get the original image
    var image = await boundary.toImage(pixelRatio: 3.0);
    ;

    // Create a new image with padding
    const double padding = 20.0; // Adjust padding size here
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    // Create a paint object for the background (white)
    final paint = Paint()..color = Colors.white;

    // Draw a rectangle with padding
    canvas.drawRect(
      Rect.fromLTWH(0, 0, image.width.toDouble() + padding * 2,
          image.height.toDouble() + padding * 2),
      paint,
    );

    // Draw the original QR code image
    canvas.drawImage(image, const Offset(padding, padding), Paint());

    // End the recording and convert to image
    final newImage = await recorder.endRecording().toImage(
          (image.width + padding * 2).toInt(),
          (image.height + padding * 2).toInt(),
        );

    // Convert the new image to bytes
    ByteData? newByteData =
        await newImage.toByteData(format: ImageByteFormat.png);
    Uint8List newPngBytes = newByteData!.buffer.asUint8List();

    // Get the directory to save the image
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = File('${directory.path}/qr_code_with_padding.png');

    // Save the image to local storage
    await imagePath.writeAsBytes(newPngBytes);
    await ImageGallerySaver.saveFile(imagePath.path);
    // print('QR code saved to gallery: ${imagePath.path}');
    if (context.mounted) showToastMessage(context, 'QR code saved to gallery');
  }

  // Share the QR code image
  // Share the QR code image
  Future<void> _shareQrCode(GlobalKey key) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Get the directory to save the image temporarily
    final directory = await getTemporaryDirectory();
    final imagePath = File('${directory.path}/qr_code.png');

    // Save the image temporarily
    await imagePath.writeAsBytes(pngBytes);

    // Share the image using XFile
    await Share.shareXFiles(
      [XFile(imagePath.path)],
      text: 'Here is my QR code!',
    );
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _qrKey = GlobalKey();

    return Scaffold(
      backgroundColor: const Color(0xfff7f9fa),
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f9fa),
        centerTitle: true,
        title: Text(
          "Scan the QR Code",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/images/download.svg'),
            onPressed: () {
              _saveQrCodeToGallery(_qrKey, context);
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  elevation: 0,
                  color: Colors.white,
                  child: Obx(() {
                    if (qrCodeController.userName.value.isEmpty) {
                      return const CircularProgressIndicator(); // Show a loading indicator
                    } else {
                      // Generate encrypted data for QR code
                      String encryptedData = generateQrCodeData(
                        qrCodeController.userName.value,
                        qrCodeController.userEmail.value,
                        qrCodeController.userPhone.value,
                        apiKey,
                      );

                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              qrCodeController.userName.value.isNotEmpty
                                  ? qrCodeController.userName.value
                                  : "User Name",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            // Display the QR code with encrypted data
                            RepaintBoundary(
                              key: _qrKey,
                              child: CustomPaint(
                                size: const Size(279.0,
                                    279.0), // Set the size of the QR code
                                painter: QrCodePainter(
                                  data: encryptedData,
                                  backgroundColor: Colors
                                      .white, // Set your desired background color
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "ID : ${qrCodeController.userId.value}",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: qrCodeController.userId.value
                                            .toString()));
                                    showToastMessage(
                                        context, "ID copied to clipboard!");
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ),
              SizedBox(
                width: 372,
                height: 61,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 199, 169, 1),
                  ),
                  onPressed: () {
                    _shareQrCode(_qrKey); // Share the QR code on button press
                  },
                  child: Text(
                    "Share this QR Code",
                    style: GoogleFonts.inter(
                        color: const Color.fromRGBO(30, 30, 30, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
