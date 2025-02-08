import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/Controller/location_controller.dart';
import '../../AppComponents/MapWidget.dart';
import '../../Utils/Assets.dart';
import '../../AppComponents/Primarybutton.dart';
import '../../AppComponents/SecondaryButton.dart';
import '../../Utils/Constants.dart';
import 'package:ride_share/View/CallingScreens/CallingScreen.dart';
import 'package:ride_share/View/Chat/ChatScreen.dart';

class ConfirmLocationScreen extends StatelessWidget {
  ConfirmLocationScreen({super.key});

  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows content behind AppBar
      backgroundColor: Colors.transparent, // Ensures transparency

      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // No shadow
        title: null, // No title
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(Assets.HamburgerIcon),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          /// **1️⃣ Map Widget - Full Screen**
          Positioned.fill(
            child: Obx(() {
              if (locationController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return const CustomMapWidget(); // Ensures the map is behind the AppBar
            }),
          ),

          /// **2️⃣ Bottom Sheet with Driver Info**
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomSheet(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Your driver is coming in 3:35",
              style: TextStyle(fontSize: 16, color: AppColors.ContentTertiary),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.ProfileImage),
                  radius: 30,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sergio Ramasis",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.ContentTertiary),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_sharp, color: AppColors.ContentTertiary),
                        Text("800m away (5 mins)", style: TextStyle(color: AppColors.LightGrey)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.WarningYellow),
                        Text("4.9 (531 reviews)", style: TextStyle(color: AppColors.LightGrey)),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(Assets.Car, width: 50),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Payment method", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("\$220.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFCADEB9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: Row(
              children: [
                Image.asset(Assets.VisaCard, width: 50),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "**** **** **** 8970",
                      style: TextStyle(fontSize: 16, color: AppColors.ContentTertiary),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Expires: 12/26",
                      style: TextStyle(fontSize: 14, color: AppColors.Info),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  text: "Call",
                  onPressed: () => Get.to(() => CallingScreen()),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryButton(
                  text: "Message",
                  onPressed: () => Get.to(() => ChatScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
