import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zero002/URLs/urls.dart';
import 'package:zero002/controllers/authenticationController.dart';
import 'package:zero002/models/userModel.dart';
import 'package:zero002/screens/LoginScreens/signupScreen.dart';
import 'package:zero002/screens/TaskScreens/mainPageScreen.dart';
import 'package:zero002/widgets/background.dart';

import '../../controllers/loginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  LoginController loginController = Get.find<LoginController>();
  AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: Text('SIGN IN',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 133, 131, 131),
                        )),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _usernameTextEditingController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'username',
                      prefixIcon: Icon(Icons.person_4_rounded),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a valid username!!!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter valid password!!!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<LoginController>(
                      builder: (loginController) {
                        return Visibility(
                          //visible: loginController.username == false,
                          replacement: Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            child: Icon(
                              Icons.arrow_circle_right_sharp,
                              size: 30,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.off(SignUpScreen());
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 16),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      // Add null-checks for username and password
      final username = _usernameTextEditingController.text.trim();
      final password = _passwordTextEditingController.text.trim();
      if (username.isEmpty || password.isEmpty) {
        // Show error message if username or password is empty
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter username and password'),
        ));
        return;
      }

      final response = await http.get(Uri.parse(
          "http://testflutter.felixeladi.co.ke/TaskManager/signin.php?username=$username&password=$password"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        int loginStatus = serverResponse['success'];
        if (loginStatus == 1) {
          print("Login Successfully");
          // Proceed with other actions
          var userData = serverResponse['userdata'];
          // ...
          print(userData);
          String? username = userData[0]['username'];
          String? emailAddress = userData[0]['emailAddress'];
          String? photo = userData[0]['photo'];
          String? userId = userData[0]['id'];
          loginController.updateUsername(username!);
          loginController.updateEmailAddress(emailAddress!);
          //loginController.updatePhoto(photo);
          loginController.updateuserID(userId);
          print("Good to go!!!");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Title(
                color: Colors.greenAccent,
                child: Text(
                  'Login was Successful',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          );
          Get.toNamed(
            '/mainScreen',
            arguments: userData,
          );
        } else {
          // Show error message for incorrect credentials
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Incorrect Credentials'),
          ));
        }
      } else {
        // Show error message for server error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Server Error ${response.statusCode}'),
        ));
      }
    } catch (e) {
      print('Error during login: $e');
      // Show error message for network error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Network Error: $e'),
      ));
    }
  }
}
