import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../controllers/authenticationController.dart';
import '../../models/userModel.dart';
import '../../widgets/background.dart';
import '../MoreScreens/moreScreen.dart';
import 'profileTab.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _userNameTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _mobileTextEditingController =
      TextEditingController();
      
  Container photoImageField() {
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
                    photo = image;
                    if (mounted) {
                      setState(() {});
                    }
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

 // AuthController authController = Get.find<AuthController>();
  bool _updatePersonalProfile = false;

  XFile? photo;

  // @override
  // void initState() {
  //   super.initState();
  //   _emailTextEditingController.text = authController.user?.emailAddress ?? '';
  //   _userNameTextEditingController.text = authController.user?.username ?? '';
  //   _mobileTextEditingController.text = authController.user?.username ?? '';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation here
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Update Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      // backgroundColor: Color.fromARGB(190, 65, 65, 66),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32,
                      ),

                      SizedBox(
                        height: 8,
                      ),
                      // photoSized(),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _emailTextEditingController,
                        decoration: InputDecoration(hintText: 'Email Address'),
                      ),

                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _mobileTextEditingController,
                        decoration: InputDecoration(hintText: 'Phone Number'),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _passwordTextEditingController,
                        decoration: InputDecoration(hintText: 'Password'),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      photoImageField(),

                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _updatePersonalProfile == false,
                          replacement: Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: updateProfile,
                            child: Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> updateProfile() async {
  //   _updatePersonalProfile = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   String? photoImage;
  //   Map<String, dynamic> inputData = {
  //     'username': _userNameTextEditingController.text.trim(),
  //     'email': _emailTextEditingController.text.trim(),
  //     'mobile': _mobileTextEditingController.text.trim(),
  //   };
  //   if (_passwordTextEditingController.text.isNotEmpty) {
  //     inputData['password'] = _passwordTextEditingController.text;
  //   }
  //   if (photo != null) {
  //     List<int> imageBytes = await photo!.readAsBytes();
  //     photoImage = base64Encode(imageBytes);
  //     inputData['photo'] = photoImage;
  //   }

  //   _updatePersonalProfile = false;
  //   if (mounted) {
  //     setState(() {});
  //   }

  // }

  Future<void> updateProfile() async {
    _updatePersonalProfile = true;
    if (mounted) {
      setState(() {});
    }

    try {
      String? photoImage;
      Map<String, dynamic> inputData = {
        'id': loginController.userID.value,
        'username': _userNameTextEditingController.text.trim(),
        'emailAddress': _emailTextEditingController.text.trim(),
        'mobileNumber': _mobileTextEditingController.text.trim(),
      };

      // Check if the password field is not empty
      if (_passwordTextEditingController.text.isNotEmpty) {
        inputData['password'] = _passwordTextEditingController.text.trim();
      }

      // Check if a photo is selected
      if (photo != null) {
        List<int> imageBytes = await photo!.readAsBytes();
        photoImage = base64Encode(imageBytes);
        inputData['photo'] = photoImage;
      }

      final response = await http.post(
        Uri.parse(
            'http://testflutter.felixeladi.co.ke/TaskManager/updateUser.php'),
        body: inputData,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          // Update successful
          print('Updated Profile Successfully');
          // Update the user information in LoginController
          loginController.updateUsername(inputData['username']);
          loginController.updateEmailAddress(inputData['email']);
          loginController.updatePhoto(inputData['photo']);
          // Navigate back to the profile screen
          Navigator.of(context).pop();
        } else {
          // Error updating profile
          print('Error updating profile: ${jsonData['error']}');
        }
      } else {
        // Server returned an error status code
        print('Error updating profile: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during request
      print('Error updating profile: $e');
    }

    _updatePersonalProfile = false;
    if (mounted) {
      setState(() {});
    }
  }

}
