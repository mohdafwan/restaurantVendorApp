import 'package:restaurant_vendor_app/models/ChatModel/Message.dart';

class ChatSubContactModel {
  int id;
  String? profileImage;
  DateTime time;
  MessageModel lastMessage;
  String issue;
  String status;
  ChatSubContactModel({
    required this.id,
    this.profileImage,
    required this.time,
    required this.lastMessage,
    required this.issue,
    required this.status,
  });

  //static fields
  static String PAYMENT_ISSUE = "Payment issue";
  static String LOGIN_ISSUE = "Unable to login";
  static String PAYOUT_REQUEST = "Request for payout";
  static String OPEN = "Open";
  static String CLOSED = "Closed";


  ChatSubContactModel copyWith({
    int? id,
    String? profileImage,
    DateTime? time,
    MessageModel? lastMessage,
    String? issue,
    String? status,
  }) {
    return ChatSubContactModel(
      id: id ?? this.id,
      profileImage: profileImage ?? this.profileImage,
      time: time ?? this.time,
      lastMessage: lastMessage ?? this.lastMessage,
      issue: issue ?? this.issue,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'profileImage': profileImage,
      'time': time.millisecondsSinceEpoch,
      'lastMessage': lastMessage.toMap(),
      'issue': issue,
      'status': status,
    };
  }

  factory ChatSubContactModel.fromMap(Map<String, dynamic> map) {
    return ChatSubContactModel(
      id: map['id'] as int,
      profileImage: map['profileImage'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      lastMessage: MessageModel.fromMap(map['lastMessage'] as Map<String,dynamic>),
      issue: map['issue'] as String,
      status: map['status'] as String,
    );
  }

  @override
  String toString() {
    return 'ChatSubContactModel(id: $id, profileImage: $profileImage, time: $time, lastMessage: $lastMessage, issue: $issue, status: $status)';
  }
}
