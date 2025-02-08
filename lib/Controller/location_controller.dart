import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../Model/location_model.dart';

class LocationController extends GetxController {
  Rx<LocationModel> userLocation = LocationModel().obs;
  Rx<LocationModel> driverLocation = LocationModel().obs;
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    getCurrentLocation(); // Fetch location on controller initialization
  }

  Future<void> getCurrentLocation() async {
    bool hasPermission = await _checkLocationPermission();
    if (!hasPermission) {
      isLoading.value = false;
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      userLocation.update((loc) {
        loc?.latitude = position.latitude;
        loc?.longitude = position.longitude;
      });

      _generateDriverLocation();
      isLoading.value = false;
    } catch (e) {
      print("⚠️ Error fetching location: $e");
      isLoading.value = false;
    }
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }

  void _generateDriverLocation() {
    if (userLocation.value.latitude == null || userLocation.value.longitude == null) return;

    const double minDistance = 5.0; // Minimum 5 km
    const double maxDistance = 30.0; // Maximum 30 km
    const double earthRadius = 6371.0; // Earth's radius in km

    double randomDistance = minDistance + Random().nextDouble() * (maxDistance - minDistance);
    double randomAngle = Random().nextDouble() * 2 * pi;

    double newLat = userLocation.value.latitude! +
        (randomDistance / earthRadius) * (180 / pi) * cos(randomAngle);
    double newLng = userLocation.value.longitude! +
        (randomDistance / earthRadius) * (180 / pi) * sin(randomAngle) / cos(userLocation.value.latitude! * pi / 180);

    driverLocation.value = LocationModel(latitude: newLat, longitude: newLng);
  }
}
