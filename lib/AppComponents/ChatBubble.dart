import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:ride_share/Utils/Constants.dart';
import '../Model/MessageModel.dart';
import '../Utils/Assets.dart';

class ChatBubbleWidget extends StatelessWidget {
  final MessageModel message;
  final bool showProfile;

  const ChatBubbleWidget({
    Key? key,
    required this.message,
    required this.showProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns to the top
        mainAxisAlignment: message.isSentByUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          // Profile Image (Only for Received Messages & First Message in Sequence)
          if (!message.isSentByUser && showProfile)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundImage: AssetImage(Assets.ChatImage),
                radius: 16,
              ),
            ),

          // Chat Bubble and Timestamp
          Column(
            crossAxisAlignment: message.isSentByUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              // Chat Bubble
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: ChatBubble(
                  clipper: message.isSentByUser
                      ? ChatBubbleClipper7(type: BubbleType.sendBubble)
                      : ChatBubbleClipper7(type: BubbleType.receiverBubble),
                  alignment: message.isSentByUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  margin: EdgeInsets.zero,
                  backGroundColor: message.isSentByUser
                      ? AppColors.primaryColor!  // Adjusted to avoid radius mismatch
                      : Colors.grey[300]!,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      message.message,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),

              ),

              // Timestamp (Slightly Shifted to the Left for Readability)
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 4, right: 4),
                child: Text(
                  _formatTimestamp(message.timestamp),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inDays < 1) {
      return "${timestamp.hour}:${timestamp.minute} ${timestamp.hour >= 12 ? 'PM' : 'AM'}";
    } else {
      return "${timestamp.day}/${timestamp.month}/${timestamp.year}";
    }
  }
}
