import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/models/chatsModel/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  const ChatBubble({super.key,
   required this.message, 
 
  });

  @override
  Widget build(BuildContext context) {
    return 
    // Align(
    //   alignment: isSentByUser ? Alignment.centerLeft : Alignment.centerRight,
    //   child: 
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
        mainAxisAlignment:
        message.isSentByUser ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (message.isSentByUser) ...[
            // User icon
            const CircleAvatar(
              radius: 12.43,
              backgroundColor: ColorPalette.userIcon,
              child: Icon(
                Icons.person_2_outlined,
                color: ColorPalette.personColor,
                size: 13.57,
              ),
            ),
           const  SizedBox(width: 14),
          ],
            Flexible(
              child: Container(
                margin: message.isSentByUser
                  ? const EdgeInsets.only(right: 50)
                  : const EdgeInsets.only(left: 50),
                //EdgeInsets.symmetric(vertical: 4, horizontal: 75),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                      spreadRadius: 0,
                      color: const Color(0xff101828).withOpacity(0.1),
                    ),
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                      spreadRadius: 0,
                      color: const Color(0xff101828).withOpacity(0.1),
                    )
                  ],
                  color: message.isSentByUser ? ColorPalette.textfieldColor : ColorPalette.receiverContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: message.isSentByUser ? const Radius.circular(0) : const Radius.circular(8),
                    topRight: const Radius.circular(8),
                    bottomLeft: message.isSentByUser ? const Radius.circular(8) : const Radius.circular(8),
                    bottomRight: message.isSentByUser ? const Radius.circular(8) : const Radius.circular(0),
                  ),
                ),
                child: Stack(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                    padding: const EdgeInsets.only(right: 60),
                      child: 
                        Text(
                        message.text,
                        style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.primaryText
                        ),
                      ),
                    ),
                  
                   // SizedBox(height: 4), // Space between text and time/tick
                  Positioned(
                    bottom: 0,
                    right: 0,
                    //alignment: PlaceholderAlignment.middle,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(message.time),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        if (!message.isSentByUser) ...[
                          const SizedBox(width: 4),
                          Icon(
                            Icons.done_all,
                            size: 16,
                            color: message.isSeen ? Colors.blue : Colors.grey,
                          ),
                        ],
                    ],
                  ),
                  ),
                  ],
                ),
              ),
                  //],
                //),
              //),
            ),
             if (!message.isSentByUser) ...[
            // Receiver icon
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 12.43,
              backgroundColor: ColorPalette.receiverIcon,
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 13,
              ),
            ),
          ],
          ],
             // ),
            ),
      );
  }
}

/// Helper function to format the message time
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }