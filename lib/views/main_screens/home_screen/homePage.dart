import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/widgets/BottomNavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String,bool> selected = {
    'All':false,
    'Ongoing':false,
    'Order Ready':false,
    'Completed':false
  };
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...selected.keys.map((label) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: _tag(context, label),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 54,),
              Center(
                child: SvgPicture.asset(
                  'assets/homeImages/OrderNotPlaced.svg',
                ),
              ),
              const SizedBox(
                height: 22.35,
              ),
              Center(
                child: Text(
                  'No Orders placed yet',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color.fromRGBO(30, 30, 30, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tag(BuildContext context,String label) {
    return ChoiceChip(
      side: BorderSide.none,
      surfaceTintColor: Colors.transparent,
      showCheckmark: false,
      selectedColor: const Color.fromRGBO(255, 244, 237, 1),
      disabledColor: const Color.fromRGBO(248, 249, 245, 1),
      backgroundColor: const Color.fromRGBO(248, 249, 245, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      labelPadding: const EdgeInsets.all(0),
      labelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: selected[label]!
              ? const Color.fromRGBO(254, 110, 57, 1)
              : const Color.fromRGBO(95, 99, 104, 1)),
      label: Text(label),
      onSelected: (value) {
        setState(() {
          selected[label] = value;
        });
      },
      selected: selected[label]!,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
