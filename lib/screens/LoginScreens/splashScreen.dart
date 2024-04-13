import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero002/screens/LoginScreens/loginScreen.dart';
import 'package:zero002/widgets/background.dart';
import '../../controllers/authenticationController.dart'; // Import your AuthController file here
import '../TaskScreens/mainPageScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Register AuthController with GetX

    goToLogin();
  }

  Future<void> goToLogin() async {
    // Check the authentication state
    final bool isLoggedIn = await Get.find<AuthController>().checkAuthState();

    // Delay for 2 seconds before navigating
    Future.delayed(Duration(seconds: 2)).then((_) {
      // Navigate to appropriate screen based on authentication state
      //Get.offAll(isLoggedIn ? MainBottomNavScreen() : LoginScreen());
      Get.off(LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using a custom background widget
      body: BodyBackground(
        child: Center(
          // Displaying an image
          child: Image.asset(
            "assets/images/pngwing.com(11).png",
            width: 120,
          ),
        ),
      ),
    );
  }
}
