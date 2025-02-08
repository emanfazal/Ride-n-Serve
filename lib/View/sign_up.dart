import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ride_share/View/ConfirmLocationScreen/ConfirmLocationScreen.dart';
import 'verify_otp.dart';// Import your VerifyOtpScreen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false; // Checkbox state

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Sign up with your email or phone number",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            // Name Input
            _buildTextField("Name"),
            const SizedBox(height: 15),

            // Email Input
            _buildTextField("Email"),
            const SizedBox(height: 15),

            // Phone Number Input with Country Code
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: _inputBoxDecoration(),
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (code) {},
                    initialSelection: 'BD',
                    favorite: ['+880', 'BD'],
                    showFlag: true,
                    showDropDownButton: true,
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your mobile number",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Gender Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: _inputBoxDecoration(),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Gender"),
                  items: ["Male", "Female", "Other"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Terms & Privacy Policy
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked; // Toggle on text tap
                      });
                    },
                    child: const Text(
                      "By signing up, you agree to the Terms of service and Privacy policy.",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Sign Up Button (Navigates to VerifyOtpScreen)
            _buildPrimaryButton("Sign Up", context),
            const SizedBox(height: 20),

            // OR Divider
            Row(
              children: const [
                Expanded(child: Divider(color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("or"),
                ),
                Expanded(child: Divider(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 20),

            // Social Media Buttons
            _buildSocialButton("Sign up with LinkedIn", "assets/linkedin.png"),
            const SizedBox(height: 20),
            _buildSocialButton("Sign up with Facebook", "assets/facebook.png"),
            const SizedBox(height: 20),
            _buildSocialButton("Sign up with Gmail", "assets/google.png"),
            const SizedBox(height: 30),

            // Already have an account? Sign in
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    // Navigate to Sign In screen
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Color(0xFF008955),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Custom Input Field
  Widget _buildTextField(String hintText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: _inputBoxDecoration(),
      child: TextField(
        decoration: InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }

  // Primary Button (Navigates to VerifyOtpScreen)
  Widget _buildPrimaryButton(String text, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF008955), // Primary Color
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OtpVerificationScreen()),
        );
      },
      child: Center(child: Text(text, style: const TextStyle(fontSize: 16))),
    );
  }

  // Social Media Buttons (PNG Support)
  Widget _buildSocialButton(String text, String iconPath) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: const BorderSide(color: Colors.grey),
      ),
      onPressed: () {
        Get.to(() => ConfirmLocationScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 24),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  // Input Box Decoration
  BoxDecoration _inputBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    );
  }
}
