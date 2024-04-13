import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero002/controllers/loginController.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the LoginController instance
    LoginController logincontroller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wrap the Text widget in Flexible
            Flexible(
                child: Text(
              'Logged-in User: ${logincontroller.username.value}',
              style: TextStyle(fontSize: 20),
            )),

            SizedBox(height: 4), // Add some spacing
            // Wrap the Text widget in Flexible
            Flexible(
                child: Text(
              'Email Address: ${logincontroller.emailAddress.value}',
              style: TextStyle(fontSize: 16),
            )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // You can add more user details here if needed
            ],
          ),
        ),
      ),
    );
  }
}
