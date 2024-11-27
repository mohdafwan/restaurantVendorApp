import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/ColorPalette.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/controllers/pages_controller/home_controller/home_controller.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/components/OperationalDaySheet.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/components/order_tile.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/components/total_order_card.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';
import 'package:restaurant_vendor_app/widgets/CustomCircularProgressIndicator.dart';
import 'package:dio/dio.dart' as dio;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final restaurentController = Get.find<RestaurantController>();
  final currentOrderController = Get.put(CurrentOrderController());
  final dio.Dio _dio = dio.Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 30,
        title: Text(
          'Orders',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: const Color.fromRGBO(30, 30, 30, 1)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Obx(() {
              return FlutterSwitch(
                width: 74,
                height: 32,
                valueFontSize: 12,
                toggleSize: 22.0,
                activeText: "Online",
                inactiveText: "Offline",
                activeColor: const Color.fromRGBO(34, 168, 34, 1),
                inactiveColor: const Color.fromRGBO(208, 217, 231, 1),
                activeTextColor: Colors.white,
                inactiveTextColor: Colors.white,
                activeTextFontWeight: FontWeight.w400,
                inactiveTextFontWeight: FontWeight.w400,
                value: restaurentController.status!,
                borderRadius: 100.0,
                padding: 4.0,
                showOnOff: true,
                onToggle: (val) {
                  if (val) {
                    showOperationalDaySheet(context);
                  } else {
                    restaurentController.updateRestaurantDetails(status: false);
                    try{
                      _dio.put(
                        "$host/restaurant/${restaurentController.id}/",
                        data: {
                          "status":false,
                        },
                        options: dio.Options(
                          headers: {
                            'Content-Type': 'application/json',
                          },
                        ),
                      );
                    }catch(error){
                      // just printing for now , till update came from backend team
                      if (kDebugMode) {
                        print(error);
                      }
                    }
                  }
                },
              );
            }),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          currentOrderController.fetchOrders();
        },
        color: themeColor,
        backgroundColor: Colors.white,
        child: Obx((){
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _searchBar(),
                  ),
                ),
            
                if (restaurentController.status!)
                  Obx(() {
                    if (currentOrderController.isLoading.value) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: CustomCircularProgressIndicator()
                        ),
                      );
                    } else if (currentOrderController.isError.value) {
                      return const SliverFillRemaining(
                        child: Center(child: Text('Error loading orders')),
                      );
                    } else if (currentOrderController.todaysOrders.isEmpty) {
                      return SliverToBoxAdapter(
                        child: _noDataMessage(),
                      );
                    } else {
                    return Obx(() {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 15.0),
                                child: OrderSummaryCard(),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 12),
                              child: OrderTile(
                                order:
                                        currentOrderController.homePageOrderList[index-1],
                                  ),
                                );
                              },
                              childCount:
                                  currentOrderController.homePageOrderList.length + 1,
                            ),
                          );
                        }
                      );
                    }
                  })
            
                // Show offline message if the restaurant is offline
                  else
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: _noDataMessage(),
                    ),
                  ),
            
                // Wrap the view history button with SliverToBoxAdapter
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Button(onPressed: () {
                          Get.find<DashboardController>().changeTabIndex(1);
                        }, text: "View History"),
                        const SizedBox(height: 54),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _noDataMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 14,
        ),
        if(restaurentController.status!)
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 15.0),
          child: OrderSummaryCard(),
        ),
        const SizedBox(
          height: 14,
        ),
        SvgPicture.asset(
          'assets/homeImages/OrderNotPlaced.svg',
        ),
        const SizedBox(
          height: 22.35,
        ),
        Obx((){
            return Text(
              restaurentController.status! ? 'No Orders Yet.' : 'You are Offline',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: const Color.fromRGBO(30, 30, 30, 1)),
            );
          }
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 13),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(width: 1, color: const Color.fromRGBO(229, 233, 235, 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_rounded,
            size: 16,
            color: Color.fromRGBO(148, 146, 146, 1),
          ),
          Expanded(
            child: TextField(
              controller: currentOrderController.searchControllerHomePage,
              cursorColor: const Color.fromRGBO(148, 146, 146, 1),
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 9,
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
}
