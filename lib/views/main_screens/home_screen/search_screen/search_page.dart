import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../controllers/pages_controller/home_controller/home_controller.dart';
import '../home_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final box = GetStorage();
  final CurrentOrderController currentOrderController = Get.find();

  @override
  void initState() {
    super.initState();
    loadSearchHistory();
  }

  void loadSearchHistory() {
    final savedHistory = box.read('searchHistory');
    if (savedHistory != null && savedHistory is List) {
      currentOrderController.searchHistory
          .assignAll(List<String>.from(savedHistory));
    }
  }

  void saveSearchHistory(String searchQuery) {
    if (searchQuery.isNotEmpty &&
        !currentOrderController.searchHistory.contains(searchQuery)) {
      currentOrderController.searchHistory.insert(0, searchQuery);
      box.write('searchHistory', currentOrderController.searchHistory);
    }
  }

  void clearSearchHistoryItem(String searchItem) {
    currentOrderController.searchHistory.remove(searchItem);
    box.write('searchHistory', currentOrderController.searchHistory);
    setState(() {});
  }

  void onSearchChanged(String value) {
    currentOrderController
        .filterOrders(value); // Filter orders based on search input
    saveSearchHistory(
        value); // Save search query to history if not already saved
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: _SearchWidget(
          controller: searchController,
          onSearch: onSearchChanged,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (currentOrderController.filteredOrders.isNotEmpty &&
                searchController.text.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${currentOrderController.filteredOrders.length} Results Found',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              if (searchController.text.isEmpty) {
                if (currentOrderController.searchHistory.isEmpty) {
                  return const Center(
                    child: Text('No search history found',
                        style: TextStyle(fontSize: 18)),
                  );
                }
                return ListView.separated(
                  itemCount: currentOrderController.searchHistory.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 0,
                    color: Colors.grey.shade200,
                  ),
                  itemBuilder: (context, index) {
                    final searchItem =
                        currentOrderController.searchHistory[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      leading: const Icon(Icons.history),
                      title: Text(searchItem),
                      trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => clearSearchHistoryItem(searchItem),
                      ),
                      onTap: () {
                        searchController.text = searchItem;
                        onSearchChanged(searchItem); // Trigger search on tap
                      },
                    );
                  },
                );
              }

              // If there are search results, show them
              if (currentOrderController.filteredOrders.isEmpty) {
                return const Center(
                  child:
                      Text('No orders found', style: TextStyle(fontSize: 18)),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: currentOrderController.filteredOrders.length,
                  itemBuilder: (BuildContext context, int index) {
                    final order = currentOrderController.filteredOrders[index];
                    return OrderTile(order: order);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const _SearchWidget({
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
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
      child: TextFormField(
        style: const TextStyle(
          color: Color(0xff111111),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        controller: controller,
        onChanged: onSearch,
        maxLines: 1,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          hintText: "Search here",
          hintStyle: TextStyle(color: const Color(0xff111111).withOpacity(0.2)),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onSearch(''); // Trigger search with empty query
                  },
                )
              : null,
        ),
      ),
    );
  }
}
