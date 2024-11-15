import 'dart:ui';

class Label {
  String label;
  Color color;

  Label({
    required this.label,
    required int color,
  }) : color = Color(color);

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
