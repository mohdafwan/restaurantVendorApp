import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/controllers/pages_controller/home_controller/home_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var logger = Logger();
  CurrentOrderController currentOrders = Get.put(CurrentOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFE6E39),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xffFE6E39),
        title: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            "Hi, Sahib",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.find<DashboardController>().changeTabIndex(2);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Current order status",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff090A0A)),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Expanded(
                child: Obx(() {
                  if (currentOrders.isLoading.value) {
                    // Loading state
                    return const Center(child: CircularProgressIndicator());
                  } else if (currentOrders.hasError.value) {
                    // Error state
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 60, color: Colors.red),
                          const SizedBox(height: 10),
                          Text(currentOrders.errorMessage.value,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black)),
                        ],
                      ),
                    );
                  } else if (currentOrders.currentOrder.isEmpty) {
                    // No data state (empty list)
                    return const Center(
                      child: Text('No orders found',
                          style: TextStyle(fontSize: 18)),
                    );
                  } else {
                    // Data state (display list of orders)
                    return ListView.builder(
                        itemCount: currentOrders.currentOrder.length,
                        itemBuilder: (BuildContext context, int index) {
                          final order = currentOrders.currentOrder[index];
                          return CurrentOrderTile(
                            title: order.restaurantName,
                            place: order.place,
                            status: order.status,
                          );
                        });
                  }
                }),
              ),

              const SizedBox(height: 20),

              //View order history Btn
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: InkWell(
                  onTap: () {
                    Get.find<DashboardController>().changeTabIndex(4);
                  },
                  child: Container(
                    width: double.infinity * 0.6,
                    height: 39,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xffFC440E),
                          width: 1,
                        )),
                    child: const Center(
                      child: Text(
                        "View order history",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffFC440E),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //Settings
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff090A0A)),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      //Setting page route
                      onTap: () {
                        Get.toNamed("/onsettingnotification");
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notification settings",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff090A0A)),
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xffFBF5E8),
                            radius: 16,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Color(0xff1E1E1E),
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              //Refer
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 117,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffFFF4ED),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 8.98,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      SizedBox(
                        width: 150,
                        height: 117,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          clipBehavior: Clip.hardEdge,
                          child: OverflowBox(
                            maxHeight: 250,
                            maxWidth: 250,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 63.0),
                              child: Container(
                                height: 230,
                                width: 230,
                                decoration: const BoxDecoration(
                                    color: Color(0xffFFE5D4),
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18, bottom: 15, left: 16, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Refer your friends",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1E1E1E),
                              ),
                            ),
                            const SizedBox(height: 14),
                            InkWell(
                              onTap: () {
                                Share.share(
                                    'check out my website https://example.com');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffFED7B3),
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Text(
                                    "Refer now",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffFC440E),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Image(
                            image: AssetImage(
                              "assets/homeImages/referfriendimage.png",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentOrderTile extends StatelessWidget {
  const CurrentOrderTile({
    super.key,
    required this.title,
    required this.place,
    required this.status,
  });
  final String title;
  final String place;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff6434F8).withOpacity(0.15),
                  offset: const Offset(1.5, 2.99),
                  blurRadius: 8.98,
                  spreadRadius: 0)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1E1E1E)),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        place,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff1E1E1E)),
                      )
                    ],
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: (status == "Preparing")
                        ? const Color(0xffFED7B3)
                        : const Color(0xffE6F5EE),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: (status == "Preparing")
                          ? const Color(0xffFC440E)
                          : const Color(0xff069855),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
