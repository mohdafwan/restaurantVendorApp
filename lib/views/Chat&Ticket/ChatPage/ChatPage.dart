import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/models/ChatModel/ChatSubContactModel.dart';
import 'package:restaurant_vendor_app/models/ChatModel/Message.dart';
import 'package:restaurant_vendor_app/views/Chat&Ticket/ChatPage/components/ChatSubContactTile.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';

import '../../tickets/raise_ticket.dart';

List<ChatSubContactTile> dummy = [
  ChatSubContactTile(
    model: ChatSubContactModel(
        id: 12345,
        time: DateTime.now(),
        lastMessage: MessageModel(
            id: 1,
            sender: '12',
            receiver: '45',
            type: MessageModel.TEXT,
            data: "Oh,Okay",
            seen: true,
            time: DateTime.now()),
        issue: ChatSubContactModel.PAYMENT_ISSUE,
        status: ChatSubContactModel.OPEN),
  ),
  ChatSubContactTile(
    model: ChatSubContactModel(
        id: 12346,
        time: DateTime.now(),
        lastMessage: MessageModel(
            id: 1,
            sender: '12',
            receiver: '45',
            type: MessageModel.TEXT,
            data: "No Problem",
            seen: false,
            time: DateTime.now()),
        issue: ChatSubContactModel.LOGIN_ISSUE,
        status: ChatSubContactModel.OPEN),
  ),
  ChatSubContactTile(
    model: ChatSubContactModel(
        id: 12347,
        time: DateTime.now(),
        lastMessage: MessageModel(
            id: 1,
            sender: '12',
            receiver: '45',
            type: MessageModel.IMAGE,
            data: "image",
            seen: true,
            time: DateTime.now()),
        issue: ChatSubContactModel.PAYOUT_REQUEST,
        status: ChatSubContactModel.OPEN),
  ),
  ChatSubContactTile(
    model: ChatSubContactModel(
        id: 12348,
        time: DateTime.now(),
        lastMessage: MessageModel(
            id: 1,
            sender: '12',
            receiver: '45',
            type: MessageModel.TEXT,
            data: "thanks",
            seen: true,
            time: DateTime.now()),
        issue: ChatSubContactModel.PAYOUT_REQUEST,
        status: ChatSubContactModel.CLOSED),
  ),
];

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 23,
        title: Text(
          "Chats",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: const Color.fromRGBO(68, 68, 68, 1)),
        ),
        actions: [
          Button(
            onPressed: () {
              Get.to(() => const SubmitIssuePage());
            },
            text: "Raise Ticket",
            fontWeight: FontWeight.w500,
            fontSize: 12,
            textColor: const Color.fromRGBO(255, 255, 255, 1),
            width: 95,
            height: 38,
          ),
          const SizedBox(
            width: 23,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: _searchBar(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _tags(
                      context: context,
                      label: 'All',
                      selected: true,
                      onSelected: (value) {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _tags(
                      context: context,
                      label: 'Open',
                      selected: false,
                      onSelected: (value) {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _tags(
                      context: context,
                      label: 'Closed',
                      selected: false,
                      onSelected: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return dummy[index];
              }, childCount: dummy.length),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 13),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: const Color.fromRGBO(181, 181, 195, 1),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_rounded,
            size: 16,
            color: Color.fromRGBO(201, 201, 201, 1),
          ),
          Expanded(
            child: TextField(
              cursorColor: const Color.fromRGBO(148, 146, 146, 1),
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color.fromRGBO(201, 201, 201, 1)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),
              ),
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _tags(
      {required BuildContext context,
      required String label,
      required bool selected,
      required void Function(bool value)? onSelected}) {
    return ChoiceChip(
      showCheckmark: false,
      selectedColor: const Color.fromRGBO(255, 244, 237, 1),
      backgroundColor: const Color.fromRGBO(248, 249, 245, 1),
      surfaceTintColor: Colors.transparent,
      label: Text(
        label,
      ),
      labelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: selected
              ? const Color.fromRGBO(254, 110, 57, 1)
              : const Color.fromRGBO(95, 99, 104, 1)),
      selected: selected,
      onSelected: onSelected,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    );
  }
}
