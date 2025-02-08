import 'package:flutter/material.dart';

import 'location.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome to RideShare!',
      'description':
      'Book rides quickly and easily. Choose from various transport options. Share rides to save money and reduce your carbon footprint.',
      'image': 'assets/welcome.png', // Replace with your asset image path
    },
    {
      'title': 'Book Your Ride',
      'description':
      'Select your transport: Car, Bike, or Van. Set your pickup and drop-off locations. Enjoy real-time tracking and seamless payments.',
      'image': 'assets/book_ride.png', // Replace with your asset image path
    },
    {
      'title': 'Share Your Ride',
      'description':
      'Save on fares by sharing rides with others. Help reduce traffic and environmental impact.',
      'image': 'assets/share_ride.png', // Replace with your asset image path
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              final data = _onboardingData[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(data['image']!, height: 300),
                    const SizedBox(height: 20),
                    Text(
                      data['title']!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data['description']!,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Navigate to the home screen or dashboard
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  EnableLocationScreen()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_currentIndex == _onboardingData.length - 1) {
                      // Navigate to the home screen or dashboard
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  EnableLocationScreen()),
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(
                          value: (_currentIndex + 1) / _onboardingData.length,
                          color: Color(0xFF008955),
                          backgroundColor: Colors.grey[300],
                          strokeWidth: 4,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF008955),
                        ),
                        child: Center(
                          child: _currentIndex == _onboardingData.length - 1
                              ? const Text(
                            'Go',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                              : const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

