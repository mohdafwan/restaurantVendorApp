import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/controllers/OrderController/OrderController.dart';
import 'package:restaurant_vendor_app/widgets/Button.dart';

class OrderTags extends StatefulWidget {
  const OrderTags({super.key});

  @override
  State<OrderTags> createState() => _OrderTagsState();
}

class _OrderTagsState extends State<OrderTags> {
  bool isExpanded = false;
  bool editing = false;
  late TextEditingController tagNameController;
  final controller = Get.find<OrderController>();
  @override
  void initState() {
    tagNameController = TextEditingController();
    tagNameController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Provide this Field";
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tag",
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(30, 30, 30, 1),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isExpanded
                    ? Colors.white
                    : const Color.fromRGBO(244, 246, 250, 1),
                boxShadow: isExpanded
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: ExpansionTile(
                minTileHeight: 32,
                title: Text(
                  controller.tags!.isEmpty
                      ? 'Choose Tag'
                      : controller.tags!.join(', '),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color.fromRGBO(30, 30, 30, 1),
                  ),
                ),
                trailing: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                ),
                onExpansionChanged: (value) {
                  setState(() {
                    isExpanded = value;
                  });
                },
                // Remove the horizontal lines by setting custom shape properties
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide.none,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide.none,
                ),
                children: [
                  const SizedBox(height: 26),
                  add(),
                  const SizedBox(height: 16),
                  Obx(() {
                    return Column(
                      children: controller.items.map((elem) {
                        String label = elem['label'];
                        Color color = Color(elem['color']);
                        return Column(
                          children: [
                            item(
                              label: label,
                              color: color,
                              selected: controller.tags!.contains(label),
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() {
                                  if (value) {
                                    controller.tags!.add(label);
                                  } else {
                                    controller.tags!.remove(label);
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                    );
                  }),
                  const SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: 176,
                      child: Button(
                        onPressed: () {
                          controller.addElement(tagNameController.text);
                          setState(() {
                            tagNameController.clear();
                            editing = false;
                          });
                        },
                        disable: tagNameController.text.isEmpty,
                        text: "Save",
                        color: const Color.fromRGBO(44, 44, 44, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  state.errorText ?? "",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget add() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              editing = true;
            });
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(235, 234, 252, 1)),
            child: Center(
              child: !editing
                  ? const Icon(
                      Icons.add,
                      color: Colors.black,
                    )
                  : SizedBox(
                      width: 16,
                      height: 16,
                      child: SvgPicture.asset('assets/images/tag.svg'),
                    ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextField(
            controller: tagNameController,
            readOnly: !editing,
            decoration: InputDecoration(
              hintText: "New Label",
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color.fromRGBO(30, 30, 30, 1),
              ),
              enabledBorder: editing
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )
                  : InputBorder.none,
              focusedBorder: editing
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )
                  : InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        if (editing)
          IconButton(
            onPressed: () {
              if (tagNameController.text.isEmpty) {
                setState(() {
                  editing = false;
                });
              }
              tagNameController.clear();
            },
            padding: const EdgeInsets.all(0),
            icon: const Icon(Icons.close),
          )
      ],
    );
  }

  Widget item(
      {required bool selected,
      required void Function(bool?) onChanged,
      required String label,
      required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: SvgPicture.asset('assets/images/tag.svg'),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: const Color.fromRGBO(30, 30, 30, 1),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: selected,
            onChanged: onChanged,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: const BorderSide(
                color: Color.fromRGBO(254, 110, 57, 1), width: 1),
            activeColor: const Color.fromRGBO(254, 110, 57, 1),
          ),
        )
      ],
    );
  }
}
