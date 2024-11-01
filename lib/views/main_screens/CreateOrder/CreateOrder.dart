import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/controllers/OrderController/OrderController.dart';
import 'package:restaurant_vendor_app/utils/toastMessage.dart';
import 'package:restaurant_vendor_app/views/main_screens/CreateOrder/components/OrderEmailField.dart';
import 'package:restaurant_vendor_app/views/main_screens/CreateOrder/components/OrderInputField.dart';
import 'package:restaurant_vendor_app/views/main_screens/CreateOrder/components/OrderPhoneField.dart';
import 'package:restaurant_vendor_app/views/main_screens/CreateOrder/components/OrderTags.dart';
import 'package:restaurant_vendor_app/views/main_screens/CreateOrder/components/OrderUniqueIdField.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';

class CreateOrder extends StatefulWidget {
  final bool edit;
  final bool phone;
  final bool mail;
  final bool uid;
  final String? encryptedString;
  const CreateOrder({
    super.key,
    this.edit = false,
    this.phone = false,
    this.mail = false,
    this.uid = false,
    this.encryptedString,
  });

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  late OrderController controller;
  @override
  void initState() {
    Get.delete<OrderController>();
    controller = Get.put(OrderController(encryptedString: widget.encryptedString));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          widget.edit? "Edit Order" : "Create Order",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color.fromRGBO(30, 30, 30, 1)
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26),
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(widget.phone)
                  const OrderPhoneField(),
                  if(widget.mail)
                  const OrderEmailField(),
                  if(widget.uid)
                  Obx(() {
                      return OrderUniqueIdField(preFill: controller.uid?.toString(),);
                    }
                  ),
                  const SizedBox(height: 24,),
                  Obx((){
                      return OrderInputField(
                        onChanged: (text) {
                          controller.customerName = text;
                        },
                        preFill: controller.customerName,
                        label: 'Customer Name',
                        hintText: "Enter here",
                      );
                    }
                  ),
                  const SizedBox(height: 24,),
                  if(widget.uid)
                  Obx((){
                      return OrderInputField(
                        onChanged: (text) {
                          controller.mail = text;
                        },
                        preFill: controller.mail,
                        label: 'Email',
                        hintText: "Enter Email here",
                      );
                    }
                  ),
                  if(!widget.uid)
                  Obx((){
                      return OrderInputField(
                        onChanged: (text) {
                          controller.uid = int.parse(text);
                        },
                        preFill: controller.uid?.toString(),
                        label: 'Unique Id',
                        hintText: "Enter Id here",
                      );
                    }
                  ),
                  const SizedBox(height: 24,),
                  OrderInputField(
                    onChanged: (text) {
                      controller.billId = int.parse(text);
                    },
                    label: 'Bill Id',
                    hintText: "Enter Bill Id here",
                    digitOnly: true,
                  ),
                  const SizedBox(height: 24,),
                  OrderInputField(
                    onChanged: (text) {
                      controller.date = text;
                    },
                    label: 'Date',
                    hintText: "Chooose Date",
                    date: true,
                  ),
                  const SizedBox(height: 24,),
                  OrderInputField(
                    onChanged: (text) {
                      controller.time = text;
                    },
                    label: 'Time',
                    hintText: "Chooose Time",
                    time: true,
                  ),
                  const SizedBox(height: 24,),
                  OrderInputField(
                    onChanged: (text) {
                      controller.amount = double.parse(text);
                    },
                    label: 'Amount',
                    hintText: "Enter Amount here",
                    digitOnly: true,
                  ),
                  const SizedBox(height: 24,),
                  OrderInputField(
                    onChanged: (text) {
                      controller.note = text;
                    },
                    label: 'Note',
                    hintText: "Enter Note here",
                    allowNull: true,
                  ),
                  const SizedBox(height: 24,),
                  const OrderTags(),
                  const SizedBox(height: 24,),
                  Button(onPressed: () async {
                    final status = await controller.submit();
                    if(!context.mounted) return; // context safe
                    if(status == null){
                      showToastMessage(context, "Order Created Successfully");
                    }else{
                      showToastMessage(context, status);
                    }
                  }, text: "Save Changes")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}