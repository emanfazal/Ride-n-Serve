import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppComponents/CallActions.dart';
import '../../AppComponents/ProfileCalling.dart';
import '../../Controller/CallController.dart';


class CallingScreen extends StatelessWidget {
  final CallController callController = Get.put(CallController());

  CallingScreen({super.key}) {
    callController.startCall(); // Start transition to talking screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( leading: Row(
        children: [

          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          // SizedBox(width: 2,),
          // Text('Back')
        ],
      ), elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ProfileDisplay(name: "Sergio Ramasis", subtitle: "Calling...."),
          const Spacer(),
          CallActions(isCalling: true), // Green call button
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
