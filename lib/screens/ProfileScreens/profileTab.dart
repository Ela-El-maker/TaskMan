import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero002/controllers/authenticationController.dart';
import 'package:zero002/controllers/loginController.dart';
import 'package:zero002/screens/MoreScreens/moreScreen.dart';
import 'package:zero002/screens/ProfileScreens/profileScreen.dart';

import '../TaskScreens/mainPageScreen.dart';
import 'editProfileScreen.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({
    Key? key,
    this.enableOnTap = true,
  }) : super(key: key);
  LoginController loginController = Get.put(LoginController());
  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      String base64Image = authController.user?.photo ?? '';
      // Remove prefix if present
      if (base64Image.startsWith('data:image')) {
        base64Image = base64Image.split(',').last;
      }
      Uint8List imageBytes = base64.decode(base64Image);

      return ListTile(
        onTap: () {
          if (enableOnTap) {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1000),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0.0, -1.0), end: Offset.zero)
                        .animate(animation),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    //ProfileScreen()
                    ProfileScreen(),
                //MoreScreen(),
              ),
            );
          }
        },
        // leading: CircleAvatar(
        //   child: NetworkImage(
        //             'http://testflutter.felixeladi.co.ke/TaskManager/Images/avatar/${loginController.photo.value}')

        //       ? Icon(Icons.person_2_outlined)
        //       : ClipRRect(
        //           borderRadius: BorderRadius.circular(30),
        //           child: Image.memory(
        //             imageBytes,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        // ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            'http://testflutter.felixeladi.co.ke/TaskManager/Images/avatar/${loginController.photo.value}',
          ),
          backgroundColor:
              Colors.grey, // Optional background color while image loads
          child: loginController
                  .photo.value.isEmpty // Display icon if photo URL is empty
              ? Icon(Icons.person_2_outlined)
              : null, // No child if there's a network image
        ),

        title: Text(
          '${loginController.username.value}',
          style: TextStyle(
            color: dark ? Colors.white : Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        // trailing: IconButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       PageRouteBuilder(
        //         transitionDuration: Duration(milliseconds: 1000),
        //         transitionsBuilder:
        //             (context, animation, secondaryAnimation, child) {
        //           return SlideTransition(
        //             position: Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
        //                 .animate(animation),
        //             child: child,
        //           );
        //         },
        //         pageBuilder: (context, animation, secondaryAnimation) =>
        //             MoreScreen(),
        //       ),
        //     );
        //   },
        //   icon: Icon(
        //     Icons.more_vert_rounded,
        //   ),
        // ),
      );
    });
  }
}
