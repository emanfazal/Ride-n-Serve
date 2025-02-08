import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:ride_share/Utils/Assets.dart';
import 'package:ride_share/Utils/Constants.dart';
import '../Controller/location_controller.dart';

class CustomMapWidget extends StatefulWidget {
  const CustomMapWidget({super.key});

  @override
  _CustomMapWidgetState createState() => _CustomMapWidgetState();
}

class _CustomMapWidgetState extends State<CustomMapWidget> {
  final LocationController locationController = Get.find<LocationController>();
  GoogleMapController? _mapController;
  LatLng? userLocation;
  LatLng? driverLocation;
  BitmapDescriptor? userMarkerIcon;
  BitmapDescriptor? driverMarkerIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (locationController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (locationController.userLocation.value.latitude == null ||
          locationController.userLocation.value.longitude == null ||
          locationController.driverLocation.value.latitude == null ||
          locationController.driverLocation.value.longitude == null) {
        return const Center(child: Text("Location not available"));
      }

      userLocation = LatLng(
        locationController.userLocation.value.latitude!,
        locationController.userLocation.value.longitude!,
      );

      driverLocation = LatLng(
        locationController.driverLocation.value.latitude!,
        locationController.driverLocation.value.longitude!,
      );

      return GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          _fitMarkers();
        },
        initialCameraPosition: CameraPosition(target: userLocation!, zoom: 14),
        markers: _buildMarkers(),
        polylines: _buildPolyline(),
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
      );
    });
  }

  /// **🔹 Load Custom Marker Icons**
  Future<void> _loadCustomMarkers() async {
    userMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)), Assets.DriverCar,
    );
    driverMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)), Assets.UserCar,
    );
    setState(() {});
  }

  /// **📍 Build Markers with Custom Images**
  Set<Marker> _buildMarkers() {
    if (userMarkerIcon == null || driverMarkerIcon == null) return {};

    return {
      Marker(
        markerId: const MarkerId("user"),
        position: userLocation!,
        icon: userMarkerIcon!,
      ),
      Marker(
        markerId: const MarkerId("driver"),
        position: driverLocation!,
        icon: driverMarkerIcon!,
      ),
    };
  }

  /// **🔹 Draw Polyline Between Markers**
  Set<Polyline> _buildPolyline() {
    return {
      Polyline(
        polylineId: const PolylineId("route"),
        color: AppColors.primaryColor,
        width: 5,
        points: [userLocation!, driverLocation!],
      ),
    };
  }

  /// **📌 Fit Both Markers in View**
  void _fitMarkers() {
    if (_mapController == null || userLocation == null || driverLocation == null) return;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        min(userLocation!.latitude, driverLocation!.latitude),
        min(userLocation!.longitude, driverLocation!.longitude),
      ),
      northeast: LatLng(
        max(userLocation!.latitude, driverLocation!.latitude),
        max(userLocation!.longitude, driverLocation!.longitude),
      ),
    );

    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }
}
