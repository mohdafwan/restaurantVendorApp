import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/models/chatsModel/message.dart';


class ChatController extends GetxController {
  var messages = <Message>[].obs;

  void addMessage(String text, bool isSentByUser) {
    messages.add(Message(
      text: text,
      isSentByUser: isSentByUser,
      time: DateTime.now(), 
      filePath: '',
      messageType: MessageType.file
    ));
  }


  // Add file message
  Future<void> addFileMessage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, // Allow specific types
      allowedExtensions: ['jpg', 'png', 'pdf', 'docx']);
      if (result != null) {
        // File selected
        String filePath = result.files.single.path ?? '';
        String fileName = result.files.single.name;


      // Determine the type (image or file)
      MessageType messageType = (fileName.endsWith('.jpg') || fileName.endsWith('.png'))
          ? MessageType.image
          : MessageType.file;

      // Add the uploaded file as a message
       messages.add(Message(
        text: fileName, // File name for the UI
        isSentByUser: true,
        time: DateTime.now(),
        filePath: filePath, // Path to the uploaded file
        messageType: messageType,
      ));


        // Send the file message to the bot (Optional)
        sendResponse('File uploaded: $fileName');
        // Notify listeners or update UI (if using state management like GetX or Provider)
      //notifyListeners(); // Or use setState() if applicable
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

// Function to mark a message as seen
  void markAsSeen(int index) {
    if (!messages[index].isSeen) {
      messages[index].isSeen = true;
      messages.refresh(); // Notify listeners
    }
  }
  // Example of a response from the bot
  // void sendResponse(String query) {
  //   addMessage("Will try to solve, wait for a few minutes", false);
  // }

  void sendResponse(String userMessage) {
  Future.delayed(const Duration(seconds: 1), () {
    addMessage("This is a bot response to: $userMessage", false);
  });
}
}