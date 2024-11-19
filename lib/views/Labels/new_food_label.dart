// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:restaurant_vendor_app/constants/color_palette.dart';
// import 'package:restaurant_vendor_app/constants/imageConstants.dart';
// import 'package:restaurant_vendor_app/views/Labels/widgets/label_tile.dart';

// class NewFoodLabel extends StatelessWidget {
//   const NewFoodLabel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      backgroundColor: ColorPalette.backgroundColor,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: ColorPalette.backgroundColor,
//         elevation: 0,
//         title: Text(
//           'Food',
//           style: GoogleFonts.inter(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: ColorPalette.primaryText,
//           ),
          
//         ),
//         leading: Container(
//           margin: const EdgeInsets.only(left: 34),
//           height: 24,
//           width: 24,
//           child: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             //splashColor: Colors.grey,
//             child: Image.asset(
//             ImageConstants.backArrow,
//             height: 15, width: 18,),
//           ),
//         ),
//         actions: [
//           Container(
//           margin: const EdgeInsets.only(right: 20),
//           height: 24,
//           width: 24,
//           child: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             //splashColor: Colors.grey,
//             child: Padding(
//               padding: const EdgeInsets.all(2.0),
//               child: Image.asset(ImageConstants.plus,
//               height: 18, width: 18,
//               fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           )
//         ],
//       ),
//       body: const Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
//         child: Column(
//           children: [
//             LabelTile(title: 'Delivered',),
//             SizedBox(height: 5,),
//             LabelTile(title: 'Not Delivered',),
//             SizedBox(height: 5,),
//             LabelTile(title: 'Pickup',),
//              SizedBox(height: 5,),
//             LabelTile(title: 'Order',),
//             SizedBox(height: 5,),
//             LabelTile(title: 'Delivered',),
//              SizedBox(height: 5,),
//             LabelTile(title: 'Not Delivered',),
//             SizedBox(height: 5,),
//             LabelTile(title: 'Pickup',),
//              SizedBox(height: 5,),
//             LabelTile(title: 'Order',),
//             SizedBox(height: 5,),
//             LabelTile(title: 'Food',),
//           ],
//         ),
//       ),

//     );
//   }
// }