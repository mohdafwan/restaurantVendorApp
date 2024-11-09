// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
// import 'package:restaurant_vendor_app/controllers/pages_controller/home_controller/home_controller.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:logger/logger.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   var logger = Logger();
//   CurrentOrderController currentOrders = Get.put(CurrentOrderController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFE6E39),
//       appBar: AppBar(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         backgroundColor: const Color(0xffFE6E39),
//         title: const Padding(
//           padding: EdgeInsets.only(left: 16.0),
//           child: Text(
//             "Hi, Sahib",
//             style: TextStyle(
//                 fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
//           ),
//         ),
//         centerTitle: false,
//         actions: [
//           GestureDetector(
//             onTap: () {
//               Get.find<DashboardController>().changeTabIndex(2);
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(right: 16),
//               child: CircleAvatar(
//                 child: Icon(Icons.person),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12), topRight: Radius.circular(12))),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
//           child: Column(
//             children: [
//               const Row(
//                 children: [
//                   Text(
//                     "Current order status",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xff090A0A)),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               Expanded(
//                 child: Obx(() {
//                   if (currentOrders.isLoading.value) {
//                     // Loading state
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (currentOrders.hasError.value) {
//                     // Error state
//                     return Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.error_outline,
//                               size: 60, color: Colors.red),
//                           const SizedBox(height: 10),
//                           Text(currentOrders.errorMessage.value,
//                               style: const TextStyle(
//                                   fontSize: 18, color: Colors.black)),
//                         ],
//                       ),
//                     );
//                   } else if (currentOrders.currentOrder.isEmpty) {
//                     // No data state (empty list)
//                     return const Center(
//                       child: Text('No orders found',
//                           style: TextStyle(fontSize: 18)),
//                     );
//                   } else {
//                     // Data state (display list of orders)
//                     return ListView.builder(
//                         itemCount: currentOrders.currentOrder.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final order = currentOrders.currentOrder[index];
//                           return CurrentOrderTile(
//                             title: order.restaurantName,
//                             place: order.place,
//                             status: order.status,
//                           );
//                         });
//                   }
//                 }),
//               ),

//               const SizedBox(height: 20),

//               //View order history Btn
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 child: InkWell(
//                   onTap: () {
//                     Get.find<DashboardController>().changeTabIndex(4);
//                   },
//                   child: Container(
//                     width: double.infinity * 0.6,
//                     height: 39,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: const Color(0xffFC440E),
//                           width: 1,
//                         )),
//                     child: const Center(
//                       child: Text(
//                         "View order history",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xffFC440E),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               //Settings
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 14.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Settings",
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xff090A0A)),
//                     ),
//                     const SizedBox(height: 5),
//                     InkWell(
//                       //Setting page route
//                       onTap: () {
//                         Get.toNamed("/onsettingnotification");
//                       },
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Notification settings",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xff090A0A)),
//                           ),
//                           CircleAvatar(
//                             backgroundColor: Color(0xffFBF5E8),
//                             radius: 16,
//                             child: Icon(
//                               Icons.arrow_forward,
//                               color: Color(0xff1E1E1E),
//                               size: 20,
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),

//               //Refer
//               Stack(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: 117,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: const Color(0xffFFF4ED),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.25),
//                           offset: const Offset(0, 4),
//                           blurRadius: 8.98,
//                           spreadRadius: 0,
//                         )
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const Expanded(
//                         child: SizedBox(),
//                       ),
//                       SizedBox(
//                         width: 150,
//                         height: 117,
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(20),
//                               bottomRight: Radius.circular(20)),
//                           clipBehavior: Clip.hardEdge,
//                           child: OverflowBox(
//                             maxHeight: 250,
//                             maxWidth: 250,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 63.0),
//                               child: Container(
//                                 height: 230,
//                                 width: 230,
//                                 decoration: const BoxDecoration(
//                                     color: Color(0xffFFE5D4),
//                                     shape: BoxShape.circle),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         top: 18, bottom: 15, left: 16, right: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Refer your friends",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xff1E1E1E),
//                               ),
//                             ),
//                             const SizedBox(height: 14),
//                             InkWell(
//                               onTap: () {
//                                 Share.share(
//                                     'check out my website https://example.com');
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: const Color(0xffFED7B3),
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: const Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 8),
//                                   child: Text(
//                                     "Refer now",
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: Color(0xffFC440E),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(right: 12.0),
//                           child: Image(
//                             image: AssetImage(
//                               "assets/homeImages/referfriendimage.png",
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CurrentOrderTile extends StatelessWidget {
//   const CurrentOrderTile({
//     super.key,
//     required this.title,
//     required this.place,
//     required this.status,
//   });
//   final String title;
//   final String place;
//   final String status;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: [
//               BoxShadow(
//                   color: const Color(0xff6434F8).withOpacity(0.15),
//                   offset: const Offset(1.5, 2.99),
//                   blurRadius: 8.98,
//                   spreadRadius: 0)
//             ]),
//         child: Padding(
//           padding: const EdgeInsets.all(22.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xff1E1E1E)),
//                   ),
//                   const SizedBox(height: 11),
//                   Row(
//                     children: [
//                       Container(
//                         height: 4,
//                         width: 4,
//                         decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(100)),
//                       ),
//                       const SizedBox(
//                         width: 6,
//                       ),
//                       Text(
//                         place,
//                         style: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff1E1E1E)),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     color: (status == "Preparing")
//                         ? const Color(0xffFED7B3)
//                         : const Color(0xffE6F5EE),
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   child: Text(
//                     status,
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: (status == "Preparing")
//                           ? const Color(0xffFC440E)
//                           : const Color(0xff069855),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/models/home/corrent_order_ststus_model.dart';
import '../../../constants/color_palette.dart';
import '../../../controllers/pages_controller/home_controller/home_controller.dart';
import 'components/popup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CurrentOrderController currentOrders =
      Get.put(CurrentOrderController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.backgroundColor,
        foregroundColor: ColorPalette.backgroundColor,
        surfaceTintColor: ColorPalette.backgroundColor,
        title: const Text(
          "Order History",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: ColorPalette.textColor,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: ColorPalette.textColor,
            ),
            onPressed: () {
              Get.toNamed('/search'); // Navigate to search page
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: DefaultTabController(
            length: 4, // Number of tabs
            child: TabBar(
              onTap: (index) {
                final tabs = ['Daily', 'Custom', 'Monthly', 'All'];
                currentOrders.updateDateLabel(tabs[index]);
              },
              tabs: const [
                Tab(text: 'Daily'),
                Tab(text: 'Custom'),
                Tab(text: 'Monthly'),
                Tab(text: 'All'),
              ],
              indicatorColor: Colors.orange,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          currentOrders.fetchOrders();
        },
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade100,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // Open date range picker
                        final pickedDateRange = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          initialDateRange: DateTimeRange(
                            start: DateTime.now()
                                .subtract(const Duration(days: 1)),
                            end: DateTime.now(),
                          ),
                        );
                        if (pickedDateRange != null) {
                          currentOrders.dateRange.value = pickedDateRange;
                          currentOrders
                              .updateDateLabel(currentOrders.selectedTab.value);
                        }
                      },
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              currentOrders.dateLabel.value,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.keyboard_arrow_down_sharp,
                                color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Open filter bottom sheet
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const FilterBottomSheet();
                          },
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "All Orders",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.keyboard_arrow_down_sharp,
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // show total order count if there are orders in the order list
                    Obx(() {
                      if (currentOrders.orderList.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Total Order: ${currentOrders.orderList.length}',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    Expanded(
                      child: Obx(() {
                        if (currentOrders.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (currentOrders.isError.value) {
                          return const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.error_outline,
                                    size: 60, color: Colors.red),
                                SizedBox(height: 10),
                                Text(
                                  'Error loading orders',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        } else if (currentOrders.orderList.isEmpty) {
                          return const Center(
                            child: Text('No orders found',
                                style: TextStyle(fontSize: 18)),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: currentOrders.orderList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final order = currentOrders.orderList[index];
                              return OrderTile(order: order);
                            },
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrentOrderController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 60,
              height: 4,
              color: Colors.grey, // Customize the color
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Filter',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildFilterSection(
            'Order Status',
            controller.statusOptions,
            controller.selectedStatuses,
            controller.toggleStatusFilter,
          ),
          const SizedBox(height: 10),
          _buildFilterSection(
            'Order Type',
            controller.orderTypeOptions,
            controller.selectedOrderTypes,
            controller.toggleOrderTypeFilter,
          ),
          const SizedBox(height: 20),
          _buildFilterActions(context, controller),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    RxList<String> selected,
    Function(String, bool) toggleFilter,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Obx(() {
          return Column(
            children: options.map((option) {
              return CheckboxListTile(
                title: Text(option),
                value: selected.contains(option),
                onChanged: (selected) =>
                    toggleFilter(option, selected ?? false),
                activeColor: Colors.orange,
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildFilterActions(
      BuildContext context, CurrentOrderController controller) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              backgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton(
            onPressed: () {
              controller.applyFilters();
              Get.back();
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

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
                          // Implement edit action
                          Navigator.pop(context);
                        }),
                        onDelete: () =>
                            PopupController.showDeleteDialog(context, () {
                          // Implement delete action
                          Navigator.pop(context);
                        }),
                      )
                    else if (order.status == 'Order Ready')
                      OrderReadyPopup(
                        onEdit: () =>
                            PopupController.showEditDialog(context, () {
                          // Implement edit action
                          Navigator.pop(context);
                        }),
                        onOngoing: () =>
                            PopupController.showRevertToOngoingDialog(context,
                                () {
                          // Mark as Ongoing action
                          Navigator.pop(context);
                        }),
                        onCompleted: () =>
                            PopupController.showRevertToCompletedDialog(context,
                                () {
                          // Mark as Completed action
                          Navigator.pop(context);
                        }),
                        onDelete: () =>
                            PopupController.showDeleteDialog(context, () {
                          // Implement delete action
                          Navigator.pop(context);
                        }),
                      )
                    else if (order.status == 'Completed')
                      CompletedPopup(
                        onEdit: () =>
                            PopupController.showEditDialog(context, () {
                          // Implement edit action
                          Navigator.pop(context);
                        }),
                        onOngoing: () =>
                            PopupController.showRevertToOngoingDialog(context,
                                () {
                          // Mark as Ongoing action
                          Navigator.pop(context);
                        }),
                        onOrderReady: () =>
                            PopupController.showRevertToOrderReadyDialog(
                                context, () {
                          // Mark as Order Ready action
                          Navigator.pop(context);
                        }),
                        onDelete: () =>
                            PopupController.showDeleteDialog(context, () {
                          // Implement delete action
                          Navigator.pop(context);
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
                              // Action for Order Ready
                            },
                            backgroundColor: ColorPalette.primaryColor,
                            textColor: Colors.white,
                            fontSize: 16,
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
                                      fontSize: 16,
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
                                      fontSize: 16,
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
    Color statusColor = Colors.green;
    if (status == 'Order Ready') {
      statusColor = Colors.orange;
    } else if (status == 'Ongoing') {
      statusColor = Colors.lightGreen;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: statusColor,
        ),
      ),
    );
  }
}

class _OrderTypeBadge extends StatelessWidget {
  final String orderType;

  const _OrderTypeBadge({required this.orderType});

  @override
  Widget build(BuildContext context) {
    Color badgeColor = Colors.blue;
    if (orderType == 'Food') {
      badgeColor = Colors.blue;
    } else if (orderType == 'Drink') {
      badgeColor = Colors.purple;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        orderType,
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

// class FilterRowWidget extends StatefulWidget {
//   const FilterRowWidget({super.key});

//   @override
//   State<FilterRowWidget> createState() => _FilterRowWidgetState();
// }

// class _FilterRowWidgetState extends State<FilterRowWidget> {
//   final controller = Get.find<CurrentOrderController>();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         FilterItem(
//           label: 'Label',
//           selectedValues: controller.selectedOrderTypes,
//           options: const ["Food", "Drink", "Snack", "Label 1", "Label 2"],
//           onOptionSelected: (value) => controller.toggleOrderTypeFilter(value),
//         ),
//         const SizedBox(width: 5),
//         FilterItem(
//           label: "Order Status",
//           selectedValues: controller.selectedStatus,
//           options: const ["Ongoing", "Order Ready", "Completed"],
//           onOptionSelected: (value) => controller.toggleStatusFilter(value),
//         ),
//         const SizedBox(width: 5),
//         DateFilterButton(
//           onDateSelected: (String date) {
//             controller.selectedDate.value = date;
//             controller.applyFilters();
//           },
//         ),
//         const SizedBox(width: 5),
//         GestureDetector(
//           onTap: () => showClearFilterConfirmationDialog(context),
//           child: const Text(
//             'Clear',
//             style: TextStyle(
//               fontSize: 12,
//               color: ColorPalette.primaryColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   showClearFilterConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         backgroundColor: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // Close button
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: ColorPalette.primaryColor.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.close,
//                         size: 14,
//                         color: ColorPalette.primaryColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Text(
//                 'Are you sure you want to clear all filters?',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Cancel Button
//                   TextButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 16,
//                       ),
//                       backgroundColor: Colors.grey.shade300,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   // Confirm Button
//                   TextButton(
//                     onPressed: () {
//                       Get.find<CurrentOrderController>().clearFilters();
//                       Get.back();
//                     },
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 16,
//                       ),
//                       backgroundColor: ColorPalette.primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: const Text(
//                       'Confirm',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DateFilterButton extends StatelessWidget {
//   final ValueChanged<String> onDateSelected;

//   const DateFilterButton({super.key, required this.onDateSelected});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<CurrentOrderController>();
//     return GestureDetector(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           confirmText: 'Apply',
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2022),
//           lastDate: DateTime(2100),
//         );
//         if (pickedDate != null) {
//           controller.setDateFilter(
//               "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}");
//         }
//       },
//       child: Obx(() {
//         return Container(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//           decoration: BoxDecoration(
//             color: controller.selectedDate.isNotEmpty
//                 ? ColorPalette.primaryColor.withOpacity(0.1)
//                 : const Color(0xffF5F5F5),
//             borderRadius: BorderRadius.circular(8.0),
//             border: Border.all(
//               color: controller.selectedDate.isNotEmpty
//                   ? Colors.transparent
//                   : const Color(0xffE5E9EB),
//             ),
//           ),
//           child: Text(
//             controller.selectedDate.isEmpty
//                 ? "Date"
//                 : controller.selectedDate.value,
//             style: TextStyle(
//               fontSize: 12,
//               color: controller.selectedDate.isNotEmpty
//                   ? ColorPalette.primaryColor
//                   : Colors.black54,
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// class FilterItem extends StatelessWidget {
//   final String label;
//   final RxList<String> selectedValues;
//   final List<String> options;
//   final Function(String) onOptionSelected;

//   const FilterItem({
//     super.key,
//     required this.label,
//     required this.selectedValues,
//     required this.options,
//     required this.onOptionSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             // Create a copy of the selected values to modify in the dialog
//             List<String> tempSelectedValues = List.from(selectedValues);
//             return Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4.0),
//               ),
//               backgroundColor: Colors.transparent,
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(4.0),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           label,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         // Close button
//                         GestureDetector(
//                           onTap: () => Navigator.of(context).pop(),
//                           child: Container(
//                             padding: const EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.withOpacity(0.1),
//                               shape: BoxShape.rectangle,
//                               border: Border.all(
//                                 color: Colors.grey.withOpacity(0.1),
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.close,
//                               size: 14,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       padding: const EdgeInsets.all(10.0),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(4),
//                         border: Border.all(
//                           color: const Color(0xffE5E9EB),
//                         ),
//                       ),
//                       child: Wrap(
//                         spacing: 8.0,
//                         runSpacing: 8.0,
//                         children: options.map((option) {
//                           bool isSelected = tempSelectedValues.contains(option);
//                           return GestureDetector(
//                             onTap: () {
//                               // Toggle selection
//                               if (isSelected) {
//                                 tempSelectedValues.remove(option);
//                               } else {
//                                 tempSelectedValues.add(option);
//                               }
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? ColorPalette.primaryColor.withOpacity(0.1)
//                                     : Colors.grey.shade200,
//                                 borderRadius: BorderRadius.circular(4.0),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   if (isSelected)
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 4.0),
//                                       child: Icon(Icons.check,
//                                           size: 16,
//                                           color: ColorPalette.primaryColor),
//                                     ),
//                                   if (isSelected) const SizedBox(width: 4),
//                                   Text(
//                                     option,
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: isSelected
//                                           ? ColorPalette.primaryColor
//                                           : Colors.black54,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           // Clear current selectedValues and add the updated ones
//                           selectedValues.clear();
//                           selectedValues.addAll(tempSelectedValues);
//                           // Notify the callback for each selected option
//                           for (var option in tempSelectedValues) {
//                             onOptionSelected(option);
//                           }
//                           Get.back();
//                         },
//                         style: TextButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 12),
//                           backgroundColor: Colors.red,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                         ),
//                         child: const Text(
//                           'Continue',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//       child: Obx(
//         () {
//           return Container(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//             decoration: BoxDecoration(
//               color: selectedValues.isNotEmpty
//                   ? Colors.blue.withOpacity(0.1)
//                   : const Color(0xffF5F5F5),
//               borderRadius: BorderRadius.circular(8.0),
//               border: Border.all(
//                 color: selectedValues.isNotEmpty
//                     ? Colors.transparent
//                     : const Color(0xffE5E9EB),
//               ),
//             ),
//             child: Text(
//               selectedValues.isEmpty
//                   ? label
//                   : selectedValues.length == 1
//                       ? selectedValues.first
//                       : "$label (${selectedValues.length})",
//               style: TextStyle(
//                 fontSize: 12,
//                 color: selectedValues.isNotEmpty ? Colors.blue : Colors.black54,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
