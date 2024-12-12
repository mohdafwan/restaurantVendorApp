// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';
import 'package:restaurant_vendor_app/controllers/tickets&chat_controller/chat_controller.dart';
import 'package:restaurant_vendor_app/views/ticket_&_chat_support.dart/widgets/chat_bubble.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});

  final ChatController controller = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();
 final ImagePicker _picker = ImagePicker();

  Future<void> _handleAttachFile(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: backgroundColor,
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  controller.addMessage("File attached: ${image.name}", true);
                  // Handle the selected file here
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  controller.addMessage("Photo captured: ${photo.name}", true);
                  // Handle the captured photo here
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(131),
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorPalette.historyShadow.withOpacity(0.1),
                      offset: const Offset(1.5, 2.99),
                      blurRadius: 8.98,
                      spreadRadius: 0
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:12, right: 12.0),
                          child: Image.asset(
                            ImageConstants.backArrow,
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                        CircleAvatar(
                          child: Icon(
                            Icons.person_2_outlined,
                            color: ColorPalette.personColor,
                            size: 24,
                          ),
                          backgroundColor: ColorPalette.textfieldColor,
                          radius: 22,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('#12346',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: ColorPalette.primaryText)),
                                const SizedBox(width: 10),
                                Row(
                                  children: [
                                   const  CircleAvatar(
                                      backgroundColor: ColorPalette.showOnline,
                                      radius: 3,
                                    ),
                                    const SizedBox(width: 5),
                                    Text('Online',
                                        style: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: ColorPalette.online)),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              'Payment Issue',
                              style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: ColorPalette.greyText.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: ChatBubble(message: message),
                      );
                    },
                  )),
            ),
            const Divider(
              height: 1,
              color: ColorPalette.divider,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                          color: ColorPalette.textField,
                          borderRadius: BorderRadius.circular(100)),
                      child: TextField(
                        cursorColor: ColorPalette.hintText,
                        maxLines: 1,
                        controller: messageController,
                        decoration: InputDecoration(
                          focusColor: ColorPalette.hintText,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          hintText: 'Type your message',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.hintText),
                          border: const OutlineInputBorder(borderSide: BorderSide.none),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.attach_file_rounded,
                            size: 24,
                            color: ColorPalette.personColor,
                          ),
                          onPressed: () => _handleAttachFile(context),
                          ),
                        ),
                       
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                        color: ColorPalette.buttonColor, shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (messageController.text.trim().isNotEmpty) {
                          controller.addMessage(messageController.text, true);
                          controller.sendResponse(messageController.text);
                          messageController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
