import 'dart:ui';

import 'package:restaurant_vendor_app/constants/ColorPalette.dart';

class Label {
  String label;
  Color color;

  Label({
    required this.label,
    int? color,
  }) : color = color == null? generateRandomLabelColor(): Color(color);

  factory Label.fromMap(Map<String, dynamic> map) {
    return Label(
      label: map['label'], 
      color: map['color'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'label': label,   
      'color': color.value,
    };
  }

  @override
  String toString() {
    return 'Label(label: $label, color: ${color.toString()})';
  }
}
