import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/color_palette.dart';
import '../../../../controllers/pages_controller/home_controller/home_controller.dart';
import '../../../../models/home/corrent_order_ststus_model.dart';
import '../../CreateOrder/CreateOrder.dart';
import 'popup.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE5E9EB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff6434F8).withOpacity(0.15),
            blurRadius: 8.98,
            offset: const Offset(1.5, 2.99),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(
                        Icons.credit_card,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      order.orderId,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Total: "),
                    Text(
                      order.totalAmount,
                    ),
                    const SizedBox(width: 5),
                    if (order.status == 'Ongoing')
                      OngoingPopup(
                        onEdit: () =>
                            PopupController.showEditDialog(context, () {
                          print(order.orderId);
                          Get.to(() => CreateOrder(orderId: order.orderId))!
                              .then((value) => Navigator.pop(context));
                        }),
                        onDelete: () =>
                            PopupController.showDeleteDialog(context, () async {
                          await Get.find<CurrentOrderController>()
                              .deleteOrder(order.orderId)
                              .then((value) => Navigator.pop(context));
                        }),
                      )
                    else if (order.status == 'Order Ready')
                      OrderReadyPopup(
                        onEdit: () =>
                            PopupController.showEditDialog(context, () {
                          print(order.orderId);

                          // Implement edit action

                          Get.to(() => CreateOrder(orderId: order.orderId))!
                              .then((value) => Navigator.pop(context));
                        }),
                        onOngoing: () =>
                            PopupController.showRevertToOngoingDialog(context,
                                () async {
                          await Get.find<CurrentOrderController>()
                              .updateStatus(order.orderId, 'ongoing')
                              .then((value) => Navigator.pop(context));
                        }),
                        onCompleted: () =>
                            PopupController.showRevertToCompletedDialog(context,
                                () async {
                          await Get.find<CurrentOrderController>()
                              .updateStatus(order.orderId, 'completed')
                              .then((value) => Navigator.pop(context));
                        }),
                        onDelete: () =>
                            PopupController.showDeleteDialog(context, () async {
                          await Get.find<CurrentOrderController>()
                              .deleteOrder(order.orderId)
                              .then((value) => Navigator.pop(context));
                        }),
                      )
                    else if (order.status == 'Completed')
                      CompletedPopup(
                        onEdit: () =>
                            PopupController.showEditDialog(context, () {
                          print(order.orderId);
                          Get.to(() => CreateOrder(orderId: order.orderId))!
                              .then((value) => Navigator.pop(context));
                        }),
                        onOngoing: () =>
                            PopupController.showRevertToOngoingDialog(context,
                                () async {
                          await Get.find<CurrentOrderController>()
                              .updateStatus(order.orderId, 'ongoing')
                              .then((value) => Navigator.pop(context));
                        }),
                        onOrderReady: () =>
                            PopupController.showRevertToOrderReadyDialog(
                                context, () async {
                          await Get.find<CurrentOrderController>()
                              .updateStatus(order.orderId, 'order ready')
                              .then((value) => Navigator.pop(context));
                        }),
                        onDelete: () =>
                            PopupController.showDeleteDialog(context, () async {
                          await Get.find<CurrentOrderController>()
                              .deleteOrder(order.orderId)
                              .then((value) => Navigator.pop(context));
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffE5E9EB),
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.userId,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _StatusBadge(status: order.status),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        order.userName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(order.date),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order.orderNumber),
                    const SizedBox(width: 10),
                    Text(order.time),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order.phoneNumber ?? ''),
                    const SizedBox(width: 10),
                    _OrderTypeBadge(orderType: order.orderType),
                  ],
                ),
              ],
            ),
          ),
          if (order.status != 'Completed')
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  order.status == 'Ongoing'
                      ? Expanded(
                          child: CustomButton(
                            text: 'Order Ready',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ConfirmOrderDialog(
                                  onNo: () {
                                    Navigator.pop(context);
                                  },
                                  onYes: () {
                                    Get.find<CurrentOrderController>()
                                        .updateStatus(
                                      order.orderId,
                                      'order ready',
                                    )
                                        .then(
                                      (value) {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                            backgroundColor: ColorPalette.primaryColor,
                            textColor: Colors.white,
                            fontSize: 14,
                            height: 44,
                            borderRadius: 10,
                          ),
                        )
                      : order.status == 'Order Ready'
                          ? Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      text: 'Notify Again',
                                      onPressed: () {
                                        // Button action
                                      },
                                      isOutlined: true,
                                      textColor: Colors.blue,
                                      borderSide:
                                          const BorderSide(color: Colors.blue),
                                      fontSize: 14,
                                      height: 44,
                                      borderRadius: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomButton(
                                      text: 'Complete',
                                      onPressed: () {
                                        // Button action
                                      },
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 14,
                                      height: 44,
                                      borderRadius: 10,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.green[700]!;
    if (status == 'Order Ready') {
      statusColor = Colors.orange;
    } else if (status == 'Ongoing') {
      statusColor = Colors.green[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: statusColor,
        ),
      ),
    );
  }
}

class _OrderTypeBadge extends StatelessWidget {
  final List<String> orderType;

  const _OrderTypeBadge({required this.orderType});

  @override
  Widget build(BuildContext context) {
    String displayType = orderType.isNotEmpty ? orderType[0] : '';

    // Set badge color based on the first item in orderType list
    Color badgeColor;
    if (displayType == 'Food') {
      badgeColor = Colors.blue;
    } else if (displayType == 'Drink') {
      badgeColor = Colors.purple;
    } else {
      badgeColor = Colors.green; // Default color for unspecified types
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayType,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: badgeColor,
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double height;
  final double borderRadius;
  final bool isOutlined; // To determine if it's an outlined button
  final BorderSide? borderSide;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xffFD4712),
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.height = 44,
    this.borderRadius = 8,
    this.isOutlined = false,
    this.borderSide,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: widget.isOutlined
          ? OutlinedButton(
              onPressed: widget.onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: widget.textColor,
                side: widget.borderSide ??
                    BorderSide(color: widget.backgroundColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
              child: Text(
                widget.text,
                style: GoogleFonts.inter(
                  color: widget.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: widget.fontSize,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
              child: Text(
                widget.text,
                style: GoogleFonts.inter(
                  color: widget.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: widget.fontSize,
                ),
              ),
            ),
    );
  }
}
