import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';
import 'package:restaurant_vendor_app/constants/imageConstants.dart';
import 'package:restaurant_vendor_app/controllers/RestaurantController/RestaurantController.dart';
import 'package:restaurant_vendor_app/models/label/label.model.dart';
import 'package:restaurant_vendor_app/views/Labels/food_label.dart';
import 'package:restaurant_vendor_app/views/Labels/widgets/add_label.dart';
import 'package:restaurant_vendor_app/views/Labels/widgets/label_tile.dart';

class Labels extends StatefulWidget {
  const Labels({super.key});

  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {

  // List to store labels
  final List<String> labels = [];

  void labelList(){

  }

final TextEditingController _labelController = TextEditingController();
final restaurantController = Get.find<RestaurantController>();

  // Function to show the Add Label dialog
  void _showAddLabelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddLabel(
            title: 'Add New Label',
            hintText: 'New One',
            controller: _labelController,
            onCancel: () {
              Navigator.pop(context);
              _labelController.clear();
            },
            onSave: (String labelText) {
              if (labelText.isNotEmpty) {
                restaurantController.updateLabels([
                  Label(label: labelText, ),
                  ...restaurantController.labels]);
                setState(() {
                  labels.add(labelText);
                   // Add the new label
                });
                _labelController.clear(); // Clear the text field
                Navigator.pop(context); // Close the bottom sheet
              }
            },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorPalette.backgroundColor,
        elevation: 0,
        title: Text(
          'Labels',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: ColorPalette.primaryText,
          ),
          
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 34),
          height: 24,
          width: 24,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            //splashColor: Colors.grey,
            child: Image.asset(
            ImageConstants.backArrow,
            height: 15, width: 18,),
          ),
        ),
        actions: [
          Container(
          margin: const EdgeInsets.only(right: 20),
          height: 24,
          width: 24,
          child: InkWell(
            onTap: _showAddLabelDialog,
            //splashColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(ImageConstants.plus,
              height: 18, width: 18,
              fit: BoxFit.cover,
              ),
            ),
          ),
          )
        ],
      ),
     body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
        child: Obx(() {
          // Use Obx to listen to the labels list in the controller
          final labels = restaurantController.labels;
          if (labels.isEmpty) {
            return const Center(
              child: Text('No labels available'),
            );
          }
          return ListView.builder(
            itemCount: labels.length,
            itemBuilder: (context, index) {
              final label = labels[index];
              return Column(
                children: [
                  LabelTile(
                    title: label.label,
                    color: Color(label.color.value),
                    onTap: () {
                      // Navigate to FoodLabel and pass data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FoodLabel(labelModel: label, index: index),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}