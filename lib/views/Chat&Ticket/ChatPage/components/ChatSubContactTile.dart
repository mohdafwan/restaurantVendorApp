import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_vendor_app/models/ChatModel/ChatSubContactModel.dart';
import 'package:restaurant_vendor_app/models/ChatModel/Message.dart';

class ChatSubContactTile extends StatefulWidget {
  final ChatSubContactModel model;
  const ChatSubContactTile({super.key, required this.model});

  @override
  State<ChatSubContactTile> createState() => _ChatSubContactTileState();
}

class _ChatSubContactTileState extends State<ChatSubContactTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 27),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 46,
              height: 46,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: const Color.fromRGBO(248, 248, 255, 1),
                backgroundImage: widget.model.profileImage != null
                    ? NetworkImage(widget.model.profileImage!)
                    : null,
                child: widget.model.profileImage == null
                    ? const Icon(
                        Icons.person_outline_outlined,
                        size: 24,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#${widget.model.id}",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: widget.model.lastMessage.type ==
                                MessageModel.IMAGE
                            ? const Icon(Icons.image_outlined,size: 16,color: Color.fromRGBO(95, 99, 104, 1),)
                            : TweenAnimationBuilder(
                                tween: Tween<double>(
                                    begin: 0,
                                    end: widget.model.lastMessage.seen ? 1 : 0),
                                duration: const Duration(milliseconds: 500),
                                builder: (context, value, child) {
                                  return Transform(
                                    transform: Matrix4.rotationY(value *2* pi),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      widget.model.lastMessage.seen
                                          ? "assets/chatImages/seen.svg"
                                          : "assets/chatImages/unread.svg",
                                    ),
                                  );
                                },
                              ),
                      ),
                      const SizedBox(width: 2,),
                      Text(
                        widget.model.lastMessage.type == MessageModel.IMAGE
                            ? "Image"
                            : widget.model.lastMessage.data,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _tag(
                          context: context,
                          label: widget.model.issue,
                          state: 1),
                      const SizedBox(
                        width: 8,
                      ),
                      _tag(
                          context: context,
                          label: widget.model.status,
                          state: widget.model.status == ChatSubContactModel.OPEN
                              ? 2
                              : 3)
                    ],
                  )
                ],
              ),
            ),
            Text(
              getFormattedTime(widget.model.time),
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color.fromRGBO(174, 174, 174, 1)),
            ),
          ],
        ),
      ),
    );
  }

  String getFormattedTime(DateTime time) {
    final now = DateTime.now();
    if (time.year == now.year &&
        time.month == now.month &&
        time.day == now.day) {
      return DateFormat('HH.mm').format(time);
    } else {
      return DateFormat('dd-MM-yy').format(time);
    }
  }

  Widget _tag(
      {required BuildContext context,
      required String label,
      required int state}) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: state == 1
            ? const Color.fromRGBO(254, 235, 200, 1)
            : state == 2
                ? const Color.fromRGBO(230, 245, 238, 1)
                : const Color.fromRGBO(255, 225, 223, 0.37),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: state == 1
              ? const Color.fromRGBO(221, 107, 32, 1)
              : state == 2
                  ? const Color.fromRGBO(6, 152, 85, 1)
                  : const Color.fromRGBO(255, 62, 51, 1),
        ),
      ),
    );
  }
}
