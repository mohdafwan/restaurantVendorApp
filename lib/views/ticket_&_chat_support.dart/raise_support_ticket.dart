// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/constants/color_palette.dart';



class RaiseSupportTicket extends StatelessWidget {
  RaiseSupportTicket({super.key});

 final TextEditingController description = TextEditingController();
 final TextEditingController uploadFileController = TextEditingController();
  
   Future<void> _pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // Get the file path
        String fileName = result.files.single.name;
        String? filePath = result.files.single.path;

        // Update the TextEditingController to show the file name
        uploadFileController.text = fileName;
       
         if (filePath != null) {
          File file = File(filePath);
          //await uploadFileToServer(file);
        // You can also handle file upload logic here if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File "$fileName" uploaded successfully!')),
        );
         }
      } else {
        // User canceled the picker
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected.')),
        );
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Platform exception occurred: $e')),
      );
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Raise Support Ticket',
            style: GoogleFonts.inter(
                fontSize: 20, fontWeight: FontWeight.w600, color: ColorPalette.fontColor),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.primaryText),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorPalette.textfieldColor,
                      ),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: ColorPalette.backgroundColor,
                        decoration: InputDecoration(
                          hintText: 'Select Category',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.primaryText),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: '1', child: Text('Category 1')),
                          DropdownMenuItem(value: '2', child: Text('Category 2')),
                        ],
                        onChanged: (value) {
                          // Handle category selection
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Order (optional)',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.primaryText),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorPalette.textfieldColor,
                      ),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: ColorPalette.backgroundColor,
                        decoration: InputDecoration(
                          hintText: 'Select Order',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.primaryText),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        // icon: Image.asset(ImageConstants.dropArrow,
                        // height: 16,
                        // width: 16,
                        // fit: BoxFit.cover,),
                        //iconSize: 16,
                        items: const [
                          DropdownMenuItem(value: '1', child: Text('Category 1')),
                          DropdownMenuItem(value: '2', child: Text('Category 2')),
                        ],
                        onChanged: (value) {
                          // Handle category selection
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upload files',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.primaryText,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorPalette.textfieldColor,
                      ),
                      child: TextField(
                        controller: uploadFileController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Upload your files',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.primaryText),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.attach_file_rounded,
                              size: 16,
                            ),
                            onPressed: ()=> _pickFile(context),
                          ),
                          // Image.asset(ImageConstants.attachFile,
                          // height: 16, width: 16,
                          // fit: BoxFit.cover,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Space between fields and description
             
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.primaryText,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 58,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorPalette.textfieldColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11.0,),
                        child: TextField(
                          controller: description,
                          cursorColor: ColorPalette.primaryText,
                          decoration: InputDecoration(
                            focusColor: ColorPalette.primaryText,
                            hintText: 'Describe the issue in detail',
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.primaryText),
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                            ),
                          ),
                          maxLines: 4,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.buttonColor,
                      minimumSize: const Size(double.infinity, 42),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    // Handle submit ticket
                  },
                  child: Text(
                    'Submit Ticket',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
