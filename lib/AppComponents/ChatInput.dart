import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatInput extends StatefulWidget {
  final TextEditingController messageController;
  final Function(bool) onToggleEmojiPicker;
  final Function(String) onSend;
  final FocusNode focusNode;

  const ChatInput({
    super.key,
    required this.messageController,
    required this.onToggleEmojiPicker,
    required this.onSend,
    required this.focusNode,
  });

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  bool _isEmojiPickerVisible = false;

  void _toggleEmojiPicker() {
    setState(() {
      _isEmojiPickerVisible = !_isEmojiPickerVisible;
    });

    if (_isEmojiPickerVisible) {
      widget.focusNode.unfocus(); // Close keyboard when emoji picker is opened
    } else {
      widget.focusNode.requestFocus(); // Open keyboard if picker is closed
    }

    widget.onToggleEmojiPicker(_isEmojiPickerVisible);
  }

  void _closeEmojiPicker() {
    if (_isEmojiPickerVisible) {
      setState(() {
        _isEmojiPickerVisible = false;
      });
      widget.onToggleEmojiPicker(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeEmojiPicker, // Close picker when tapping outside
      child: Column(
        children: [
          if (_isEmojiPickerVisible)
            SizedBox(
              height:100,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  setState(() {
                    widget.messageController.text += emoji.emoji;
                  });
                },
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 28),
                  onPressed: () {}, // Handle attachment action
                ),
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined, size: 24),
                  onPressed: _toggleEmojiPicker,
                ),
                Expanded(
                  child: TextField(
                    controller: widget.messageController,
                    focusNode: widget.focusNode,
                    onTap: _closeEmojiPicker, // Close emoji picker when typing
                    decoration: InputDecoration(
                      hintText: "Type your message",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue, size: 28),
                  onPressed: () {
                    if (widget.messageController.text.isNotEmpty) {
                      widget.onSend(widget.messageController.text);
                      widget.messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
