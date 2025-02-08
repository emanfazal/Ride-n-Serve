import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'getstarted.dart';

class EnableLocationScreen extends StatefulWidget {
  @override
  _EnableLocationScreenState createState() => _EnableLocationScreenState();
}

class _EnableLocationScreenState extends State<EnableLocationScreen> {
  GoogleMapController? _mapController;
  LatLng _defaultLocation = LatLng(37.7749, -122.4194); // Default: SF
  LatLng? _currentPosition;

  Future<void> _fetchLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_currentPosition!, 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _defaultLocation,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            myLocationEnabled: true,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, size: 50, color: Color(0xFF008955),),
                  SizedBox(height: 10),
                  Text("Enable your location",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Choose your location to find requests near you",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _fetchLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF008955),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text("Use my location"),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the GetStarted screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => GetStartedScreen()),
                      );
                    },
                    child: const Text("Skip for now", style: TextStyle(color: Colors.grey)),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
