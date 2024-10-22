import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/pages_controller/history_controller/history_controller.dart';
import 'package:restaurant_vendor_app/models/OrderHistory/lorder_history_model.dart';

class OrderHistoryView extends StatelessWidget {
  final OrderHistoryController controller = Get.put(OrderHistoryController());
  final TextEditingController searchController = TextEditingController();

  OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Order history",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff090A0A)),
        ),
        actions: [
          PopupMenuButton(
            color: Colors.white,
            offset: const Offset(-23, 35),
            iconSize: 30,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  padding: const EdgeInsets.only(
                      top: 6, bottom: 6, left: 15, right: 15),
                  height: 8,
                  enabled: false,
                  child: GestureDetector(
                    onTap: () {
                      log("send feedback");
                    },
                    child: const Text(
                      "Send feedback",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(),
            const SizedBox(height: 20),
            // Status Dropdown
            Row(
              children: [
                const Expanded(child: SizedBox()),
                _buildStatusDropdown(),
              ],
            ),
            const SizedBox(height: 20),
            // Order List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.hasError.value) {
                  return Center(child: Text(controller.errorMessage.value));
                } else if (controller.filteredOrders.isEmpty) {
                  return const Center(child: Text("No orders found"));
                } else {
                  return ListView.builder(
                    itemCount: controller.filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = controller.filteredOrders[index];
                      return ListTile(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        leading: CircleAvatar(
                          radius: 23,
                          backgroundColor: const Color(0xffD9D9D9),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(order.imgUrl),
                              radius: 22),
                        ),
                        title: Text(
                          order.title,
                          style: const TextStyle(
                              color: Color(0xff344054),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          order.date,
                          style: const TextStyle(
                              color: Color(0xff444444),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Text(
                          order.status,
                          style: TextStyle(
                              color: order.status == "Delivered"
                                  ? const Color(0xff069855)
                                  : const Color(0xffFC440E),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () =>
                            _showOrderDetailsBottomSheet(context, order),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return Obx(
      () {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE5E9EB), width: 1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff6434F8).withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 8.98,
                offset: const Offset(1.5, 2.99),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 0.0), // Optional adjustment
            child: TextFormField(
              style: const TextStyle(
                color: Color(0xff111111),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              controller: searchController,
              onChanged: (value) => controller.filterOrders(value),
              maxLines: 1,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                isCollapsed: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15), // Adjust padding
                suffixIcon: controller.searchQuery.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            controller.filterOrders('');
                            searchController.clear();
                          },
                          child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xffFFF4ED),
                              ),
                              child: const Icon(
                                CupertinoIcons.multiply,
                                size: 20,
                              )),
                        ),
                      )
                    : null,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/historyimages/searchicon.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                hintText: "Search for orders",
                hintStyle:
                    TextStyle(color: const Color(0xff111111).withOpacity(0.2)),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Status Dropdown Widget
  Widget _buildStatusDropdown() {
    return Obx(() {
      return Container(
        height: 36,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xffEAECF0)),
            borderRadius: BorderRadius.circular(8)),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              isDense: true,
              iconSize: 14,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              value: controller.selectedStatus.value,
              onChanged: (value) {
                if (value != null) {
                  controller.filterByStatus(value);
                }
              },
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              dropdownColor: Colors.white,
              icon: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 14,
                ),
              ),
              items: ["Status", "Ready to pickup", "Preparing", "Delivered"]
                  .map((status) =>
                      DropdownMenuItem(value: status, child: Text(status)))
                  .toList(),
            ),
          ),
        ),
      );
    });
  }

  // Bottom Sheet to Show Order Details
  void _showOrderDetailsBottomSheet(BuildContext context, Order order) {
    showModalBottomSheet(
      constraints: const BoxConstraints.expand(),
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
      ),
      backgroundColor: const Color(0xffFAFAFA).withOpacity(0.93),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(13)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: const Color(0xffD9D9D9),
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(order.imgUrl),
                                  radius: 34),
                            ),
                            const SizedBox(height: 12),
                            Text(order.title,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(order.title,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child:
                          Container(height: 1, color: const Color(0xffDADADA)),
                    ),

                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 17),
                      child: Column(
                        children: [
                          const IconList(
                              icon: Icons.location_pin,
                              text: "Old Mahabalipuram Road, Thiruporur"),
                          const SizedBox(height: 5),
                          IconList(
                              icon: Icons.calendar_month,
                              text: "Date of order : ${order.date}"),
                          const SizedBox(height: 5),
                          IconList(
                              icon: CupertinoIcons.bag_fill,
                              text: "Delivered on ${order.date}"),
                          const SizedBox(height: 5),
                          IconList(
                              icon: CupertinoIcons.creditcard_fill,
                              text: "Order id : ${order.date}"),
                          const SizedBox(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 133,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFD4712),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Unlink",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  deletePupUp(context);
                                },
                                child: Container(
                                  width: 133,
                                  height: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEBE9FC),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Color(0xff303030),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFF4ED),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xff76757A),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

  Future<dynamic> deletePupUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: const Color(0xffFFEFE4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.warning_rounded,
                                color: Color(0xffFA5C00)),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Delete",
                                    style: TextStyle(
                                        color: Color(0xff11151F),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  width: 160,
                                  child: Text("Are you sure want to delete?",
                                      softWrap: true),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    // ---------- Yes ------ no ----

                                    Container(
                                      width: 49,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: Color(0xff445275),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 49,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                          color: Color(0xff445275),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              Icons.close,
                              size: 20,
                              color: Color(0xff445275),
                            ),
                          ),
                        )
                      ]),
                ],
              ));
        });
  }
}

class IconList extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconList({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundColor: const Color(0xffFFF4ED),
          child: Icon(
            icon,
            size: 14,
            color: const Color(0xffFD4712),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff565D6D)),
        )
      ],
    );
  }
}
