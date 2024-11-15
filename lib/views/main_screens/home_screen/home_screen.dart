import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restaurant_vendor_app/widgets/CustomCircularProgressIndicator.dart';
import '../../../constants/color_palette.dart';
import '../../../controllers/pages_controller/home_controller/home_controller.dart';
import 'components/order_tile.dart';
import 'components/total_order_card.dart';

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
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (didPop,result){
      //   Get.find<DashboardController>().changeTabIndex(0);
      // },
         onPopInvoked: (didPop) {
          Get.find<DashboardController>().changeTabIndex(0);
         },
      child: Scaffold(
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
                onTap: (index) => currentOrders.updateDateLabel(index),
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
          color: themeColor,
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade100,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentOrders.selectedTab.value != 3) ...[
                        GestureDetector(
                          onTap: () => currentOrders.selectDate(context),
                          child: Obx(() => Row(
                                children: [
                                  Text(
                                    currentOrders.dateLabel.value,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.keyboard_arrow_down_sharp,
                                      color: Colors.black),
                                ],
                              )),
                        ),
                        const SizedBox(width: 10),
                      ],
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => const FilterBottomSheet(),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              "All Orders",
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.keyboard_arrow_down_sharp,
                                color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    Obx(() {
                      if (currentOrders.isLoading.value) {
                        return const SliverFillRemaining(
                          child: Center(child: CustomCircularProgressIndicator()),
                        );
                      } else if (currentOrders.isError.value) {
                        return const SliverFillRemaining(
                          child: Center(
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
                          ),
                        );
                      } else if (currentOrders.orderList.isEmpty) {
                        return const SliverFillRemaining(
                          child: Center(
                              child: Text('No orders found',
                                  style: TextStyle(fontSize: 18))),
                        );
                      } else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Text(
                                          'Total Order: ${currentOrders.orderList.length}',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      OrderSummaryCard(),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              }
                              final order = currentOrders.orderList[index - 1];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: OrderTile(order: order),
                              );
                            },
                            childCount: currentOrders.orderList.length + 1,
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
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
