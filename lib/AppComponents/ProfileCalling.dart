import 'package:flutter/material.dart';

import '../Utils/Assets.dart';

class ProfileDisplay extends StatelessWidget {
  final String name;
  final String subtitle;

  const ProfileDisplay({super.key, required this.name, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(Assets.ChatImage), // Update with actual image
        ),
        const SizedBox(height: 10),
        Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(subtitle, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}
