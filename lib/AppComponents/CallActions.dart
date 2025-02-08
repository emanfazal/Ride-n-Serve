import 'package:flutter/material.dart';

class CallActions extends StatelessWidget {
  final bool isCalling;

  const CallActions({super.key, required this.isCalling});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIcon(Icons.camera_alt, Colors.green[100]!),
        _buildIcon(Icons.mic_off, Colors.green[100]!),
        FloatingActionButton(
          onPressed: () {}, // Add call action logic
          backgroundColor: isCalling ? Colors.green : Colors.red,
          child: Icon(isCalling ? Icons.call : Icons.call_end, color: Colors.white),
        ),
        _buildIcon(Icons.video_call, Colors.green[100]!),
        _buildIcon(Icons.more_horiz, Colors.green[100]!),
      ],
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 25,
        child: Icon(icon, color: Colors.black54),
      ),
    );
  }
}
