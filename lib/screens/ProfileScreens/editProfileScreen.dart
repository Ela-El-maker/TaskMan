import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:zero002/controllers/authenticationController.dart';
import 'package:zero002/screens/ProfileScreens/profileScreen.dart';
import 'package:zero002/widgets/background.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreeen extends StatefulWidget {
  const EditProfileScreeen({super.key});

  @override
  State<EditProfileScreeen> createState() => _EditProfileScreeenState();
}

class _EditProfileScreeenState extends State<EditProfileScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: GlassmorphicContainer(
          width: MediaQuery.of(context).size.width,
          height: 100,
          borderRadius: 30, // Adjust border radius for a more glassy effect
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 46, 150, 152).withOpacity(0.1),
              Color.fromARGB(255, 22, 198, 119).withOpacity(0.05),
            ],
            stops: [
              0.1,
              1,
            ],
          ),
          border: 2,
          blur: 20,
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.5),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Make app bar transparent
            title: Text('View Profile'),
            centerTitle: true,
            elevation: 0, // Remove app bar shadow
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1000),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position:
                                Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
                                    .animate(animation),
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ProfileScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.forward_outlined,
                    size: 50,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
