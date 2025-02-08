import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../View/CallingScreens/TalkingScreen.dart';

class CallController extends GetxController {
  void startCall() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => TalkingScreen());
    });
  }
}
