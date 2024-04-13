import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zero002/screens/LoginScreens/loginScreen.dart';
import 'package:zero002/widgets/background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameTextEditingController =
      TextEditingController();

  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _mobileTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
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
                    Text(
                      'Come with Us...',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _usernameTextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'username',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter valid username!!!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _emailTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your Email address...';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _mobileTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Mobile Number',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your phone number...';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your password...';
                        }
                        if (value!.length < 6) {
                          return 'Enter password with more than 6 characters...';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: _signUp,
                            child: Icon(Icons.arrow_circle_right_outlined)),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.off(LoginScreen());
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(fontSize: 16),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    http.Response response;
    var body = {
      'username': _usernameTextEditingController.text.trim(),
      'emailAddress': _emailTextEditingController.text.trim(),
      'mobileNumber': _mobileTextEditingController.text.trim(),
      'password': _passwordTextEditingController.text.trim(),
    };
    response = await http.post(
        Uri.parse("http://testflutter.felixeladi.co.ke/TaskManager/signup.php"),
        body: body);

    if (response.statusCode == 200) {
      var serverResponse = json.decode(response.body);
      int signup = serverResponse['success'];
      if (signup == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Title(
                color: const Color.fromARGB(255, 78, 80, 79),
                child: Text(
                  'Account created Sucessfully',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.greenAccent,
                  ),
                )),
          ),
        );
        _clearTextFields();
        Get.offAndToNamed('/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Title(
                color: const Color.fromARGB(255, 78, 80, 79),
                child: Text(
                  'Account creation failed! Please try again.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
                  ),
                )),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Title(
            color: Color.fromARGB(255, 217, 5, 40),
            child: Text(
              'Server Error ${response.statusCode}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            )),
      ));
    }
  }

  void _clearTextFields() {
    _usernameTextEditingController.clear();
    _emailTextEditingController.clear();
    _mobileTextEditingController.clear();
    _passwordTextEditingController.clear();
  }
}
