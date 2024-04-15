import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

  XFile? photo;
  bool _obscureText = true;

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
                  Text('SIGN UP',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 133, 131, 131),
                      )),
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      prefixIcon: Icon(Icons.email_outlined),
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
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      prefixIcon: Icon(Icons.phone_android_outlined),
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
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _obscureText
                                  ? Colors.grey
                                  : Colors
                                      .blue, // Change color based on visibility
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText =
                                    !_obscureText; // Toggle text visibility
                              });
                            })),
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
                  photoImageField(),
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
    );
  }

  // photoImageField widget
  Widget photoImageField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              alignment: Alignment.center,
              child: Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: InkWell(
                onTap: () async {
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.camera, imageQuality: 50);
                  if (image != null) {
                    setState(() {
                      photo = image;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Visibility(
                    visible: photo == null,
                    replacement: Text(photo?.name ?? ''),
                    child: Text('Select photo'),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future<void> _signUp() async {
    http.Response response;
    // var body = {
    //   'username': _usernameTextEditingController.text.trim(),
    //   'emailAddress': _emailTextEditingController.text.trim(),
    //   'mobileNumber': _mobileTextEditingController.text.trim(),
    //   'password': _passwordTextEditingController.text.trim(),
    // };

    String? photoImage;
    Map<String, dynamic> inputData = {
      'username': _usernameTextEditingController.text.trim(),
      'emailAddress': _emailTextEditingController.text.trim(),
      'mobileNumber': _mobileTextEditingController.text.trim(),
      'password': _passwordTextEditingController.text.trim(),
    };

    // Check if the password field is not empty
    // if (_passwordTextEditingController.text.isNotEmpty) {
    //   inputData['password'] = _passwordTextEditingController.text.trim();
    // }

    // Check if a photo is selected
    if (photo != null) {
      List<int> imageBytes = await photo!.readAsBytes();
      photoImage = base64Encode(imageBytes);
      inputData['photo'] = photoImage;
    }

    response = await http.post(
        Uri.parse("http://testflutter.felixeladi.co.ke/TaskManager/signup.php"),
        body: inputData);

    // if (response.statusCode == 200) {
    //   var serverResponse = json.decode(response.body);
    //   int signup = serverResponse['success'];
    //   if (signup == 1) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Title(
    //             color: const Color.fromARGB(255, 78, 80, 79),
    //             child: Text(
    //               'Account created Sucessfully',
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w900,
    //                 color: Colors.greenAccent,
    //               ),
    //             )),
    //       ),
    //     );
    //     _clearTextFields();
    //     Get.offAndToNamed('/');
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Title(
    //             color: const Color.fromARGB(255, 78, 80, 79),
    //             child: Text(
    //               'Account creation failed! Please try again.',
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w900,
    //                 color: Colors.red,
    //               ),
    //             )),
    //       ),
    //     );
    //   }
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Title(
    //         color: Color.fromARGB(255, 217, 5, 40),
    //         child: Text(
    //           'Server Error ${response.statusCode}',
    //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
    //         )),
    //   ));
    if (mounted) {
      if (response.statusCode == 200) {
        print('Error :  ${response.statusCode}');
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
          print('Error :  ${response.statusCode}');
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
        print('Error :  ${response.statusCode}');
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
  }

  void _clearTextFields() {
    _usernameTextEditingController.clear();
    _emailTextEditingController.clear();
    _mobileTextEditingController.clear();
    _passwordTextEditingController.clear();
  }
}
