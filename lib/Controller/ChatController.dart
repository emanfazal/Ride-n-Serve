import 'package:get/get.dart';

import '../Model/MessageModel.dart';


class ChatController extends GetxController {
  RxList<MessageModel> messages = <MessageModel>[].obs;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    messages.add(MessageModel(
      message: text,
      isSentByUser: true,
      timestamp: DateTime.now(),
    ));

    // Simulate a bot response after a delay
    Future.delayed(const Duration(seconds: 1), () {
      messages.add(MessageModel(
        message: "Welcome to Car2Go Customer Service",
        isSentByUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }
}
