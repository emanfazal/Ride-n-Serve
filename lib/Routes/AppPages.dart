import 'package:get/get.dart';
import 'package:ride_share/View/Chat/ChatScreen.dart';
import 'package:ride_share/View/ConfirmLocationScreen/ConfirmLocationScreen.dart';
import '../view/splash_screen.dart';
import '../view/onboarding_screen.dart';
import '../view/location.dart';
import 'AppRoutes.dart';


class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.enableLocation,
      page: () => EnableLocationScreen(),
    ),
    GetPage(
      name: AppRoutes.confirmLocation,
      page: () => ConfirmLocationScreen(),
    ),
    GetPage(
      name: AppRoutes.ChatScreen,
      page: () => ChatScreen(),
    ),
  ];
}
