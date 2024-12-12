enum MessageType {file, image}

class Message {
  final String text;
  final bool isSentByUser;
  final DateTime time;
  bool isSeen;
  final String? filePath;
  final MessageType messageType;

  Message({
    this.text = '',
    required this.isSentByUser,
    required this.time,
    this.isSeen = false,
    required this.filePath, 
    required this.messageType,
  });
}
