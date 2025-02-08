import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppComponents/CallActions.dart';
import '../../AppComponents/ProfileCalling.dart';


class TalkingScreen extends StatelessWidget {
  const TalkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( leading: Row(
      children: [

      IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Get.back(),
    ),
    // SizedBox(width: 5,),
    // Text('Back')
    ],
    ), elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ProfileDisplay(name: "Sergio Ramasis", subtitle: "01:23"), // Call duration
          const Spacer(),
          const CallActions(isCalling: false), // Red hang-up button
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
