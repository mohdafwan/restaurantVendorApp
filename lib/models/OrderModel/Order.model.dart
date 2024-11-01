class OrderModel {
  String? customerName;
  String? phoneNumber;
  String? time;
  String? date;
  int? billId;
  double? amount;
  String? note;
  int? uid;
  String? mail;
  List<String>? tags;

  OrderModel({
    this.customerName,
    this.phoneNumber,
    this.time,
    this.date,
    this.billId,
    this.amount,
    this.note,
    this.uid,
    this.mail,
    this.tags,
  });

  OrderModel copyWith({
    String? customerName,
    String? phoneNumber,
    String? time,
    String? date,
    int? billId,
    double? amount,
    String? note,
    int? uid,
    String? mail,
    List<String>? tags,
  }) {
    return OrderModel(
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      time: time ?? this.time,
      date: date ?? this.date,
      billId: billId ?? this.billId,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      uid: uid ?? this.uid,
      mail: mail ?? this.mail,
      tags: tags ?? this.tags,
    );
  }

  // ToMap method
  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'time': time,
      'date': date,
      'billId': billId,
      'amount': amount,
      'note': note,
      'uid': uid,
      'mail': mail,
      'tags': tags,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      customerName: map['customerName'],
      phoneNumber: map['phoneNumber'],
      time: map['time'],
      date: map['date'],
      billId: map['billId'],
      amount: map['amount'],
      note: map['note'],
      uid: map['uid'],
      mail: map['mail'],
      tags: List<String>.from(map['tags'] ?? []),
    );
  }
}
