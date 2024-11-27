class MessageModel {
  int id;
  String sender;
  String receiver;
  String type;
  dynamic data;
  bool seen;
  DateTime time;
  MessageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.type,
    required this.data,
    required this.seen,
    required this.time,
  });

  //static fields
  static String TEXT = "text";
  static String IMAGE = "image";

  MessageModel copyWith({
    int? id,
    String? sender,
    String? receiver,
    String? type,
    dynamic data,
    bool? seen,
    DateTime? time,
  }) {
    return MessageModel(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      type: type ?? this.type,
      data: data ?? this.data,
      seen: seen ?? this.seen,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'type': type,
      'data': data,
      'seen': seen,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as int,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      type: map['type'] as String,
      data: map['data'] as dynamic,
      seen: map['seen'] as bool,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  @override
  String toString() {
    return 'MessageModel(id: $id, sender: $sender, receiver: $receiver, type: $type, data: $data, seen: $seen, time: $time)';
  }
}
