import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import '../../AppComponents/ChatBubble.dart';
import '../../AppComponents/ChatInput.dart';
import '../../Model/MessageModel.dart';



class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<MessageModel> messages = List.from(dummyMessages);
  bool showEmojiPicker = false;
  final TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() => showEmojiPicker = false);
      }
    });
  }

  void _toggleEmojiPicker() {
    setState(() {
      showEmojiPicker = !showEmojiPicker;
      if (showEmojiPicker) {
        focusNode.unfocus();
      } else {
        focusNode.requestFocus();
      }
    });
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add(MessageModel(
        message: messageController.text.trim(),
        isSentByUser: true,
        timestamp: DateTime.now(),
      ));
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Center(child: Text("Chat")),
        leading: Row(
          children: [
            
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
            // SizedBox(width: 2,),
            // Text('Back')
          ],
        ),
      ),
      body: GestureDetector(

      onTap: () {
    if (showEmojiPicker) {
    setState(() => showEmojiPicker = false);
    }},
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubbleWidget(
                    message: messages[index],
                    showProfile: _shouldShowProfile(index),
                  );
                },
              ),
            ),



        // In the build method, pass a function with the correct signature
            ChatInput(
            messageController: messageController,
            onToggleEmojiPicker: (show) => _toggleEmojiPicker(), // ✅ Fixed
            onSend: (message) => _sendMessage(), // Adjusted based on your _sendMessage method
            focusNode: focusNode,
            ),



            if (showEmojiPicker) _buildEmojiPicker(),
          ],
        ),
      ),
    );
  }

  bool _shouldShowProfile(int index) {
    if (index == 0) return true;
    return messages[index].isSentByUser != messages[index - 1].isSentByUser;
  }

  Widget _buildEmojiPicker() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          messageController.text += emoji.emoji;
        },
      ),
    );
  }
}
