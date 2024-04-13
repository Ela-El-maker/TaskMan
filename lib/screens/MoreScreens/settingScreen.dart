/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zero002/controllers/loginController.dart';

import 'package:zero002/screens/ProfileScreens/profileTab.dart';

import '../ProfileScreens/profileScreen.dart';
import '../TaskScreens/mainPageScreen.dart';
import 'moreScreen.dart';

class SettingsOnePage extends StatefulWidget {
  SettingsOnePage({super.key});

  LoginController loginController = Get.put(LoginController());
  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  @override
  void initState() {
    super.initState();
    dark = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80.0),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                          color: Colors.purple,
                        ),
                        title: const Text("Change Password"),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          //open change password
                        },
                      ),
                      _buildDivider(),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.language,
                          color: Colors.purple,
                        ),
                        title: const Text("Change Language"),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          //open change language
                        },
                      ),
                      _buildDivider(),
                      ListTile(
                        leading: const Icon(
                          Icons.location_on,
                          color: Colors.purple,
                        ),
                        title: const Text("Change Location"),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          //open change location
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SwitchListTile(
                  activeColor: Colors.purple,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: const Text("Received notification"),
                  onChanged: (val) {},
                ),
                const SwitchListTile(
                  activeColor: Colors.purple,
                  contentPadding: EdgeInsets.all(0),
                  value: false,
                  title: Text("Received newsletter"),
                  onChanged: null,
                ),
                SwitchListTile(
                  activeColor: Colors.purple,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: const Text("Received Offer Notification"),
                  onChanged: (val) {},
                ),
                const SwitchListTile(
                  activeColor: Colors.purple,
                  contentPadding: EdgeInsets.all(0),
                  value: true,
                  title: Text("Received App Updates"),
                  onChanged: null,
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 00,
            left: 00,
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.powerOff,
                color: Colors.white,
              ),
              onPressed: () {
                //log out
                // Assuming you're using GetX for state management, you can clear user data like this:

                // Navigate to the login screen
                Get.offAllNamed(
                    '/'); // Navigate to the login screen and remove all other routes from the stack
              },
            ),
          )
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
