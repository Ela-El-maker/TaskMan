// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zero002/controllers/loginController.dart';

// class MoreScreen extends StatelessWidget {
//   final LoginController loginController = Get.find<LoginController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           color: Colors.blue,
//           padding: EdgeInsets.all(20), // Add padding for spacing
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize
//                 .min, // Adjust the mainAxisSize to minimize the space
//             children: [
//               Text(
//                 'Logged-in User: ${loginController.username.value}',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 10), // Add spacing between the texts
//               Obx(() => Text(
//                     'Email Address: ${loginController.emailAddress.value}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero002/controllers/loginController.dart';
import 'package:zero002/controllers/taskController.dart';
import 'package:zero002/screens/MoreScreens/settingScreen.dart';
import 'package:zero002/screens/TaskScreens/mainPageScreen.dart';
import 'package:zero002/screens/TaskScreens/newPage.dart';
import 'package:zero002/widgets/cards.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

TaskController taskController = Get.put(TaskController());
LoginController loginController = Get.put(LoginController());

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.blueGrey, // Custom color
              ),
            ),
          ),
          Positioned(
            top: -100.0,
            left: 100.0,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                width: 150,
                height: 300,
              ),
            ),
          ),
          Positioned(
            bottom: -120.0,
            right: 90.0,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                width: 150,
                height: 300,
              ),
            ),
          ),
          Positioned(
            top: -50.0,
            left: 30.0,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                width: 150,
                height: 200,
              ),
            ),
          ),
          Positioned(
            bottom: -80.0,
            right: 0.0,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                width: 150,
                height: 200,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Image.network(
                      'http://testflutter.felixeladi.co.ke/TaskManager/Images/avatar/${loginController.photo.value}',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  // newTaskController.getNewTaskList();
                },
                splashColor: Colors.blueGrey, // Custom color
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Activities",
                    style: TextStyle(color: Colors.white), // Custom text style
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                splashColor: Colors.blueGrey, // Custom color
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                              color: Colors.white), // Custom text style
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 5.0),
                        const CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueGrey, // Custom color
                          child: Text("5"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                splashColor: Colors.blueGrey, // Custom color
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Help",
                    style: TextStyle(color: Colors.white), // Custom text style
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsOnePage()),
                  );
                },
                splashColor: Colors.blueGrey, // Custom color
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Settings",
                    style: TextStyle(color: Colors.white), // Custom text style
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: MaterialButton(
                elevation: 0,
                padding: const EdgeInsets.all(16.0),
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.grey.shade800,
                child: const Icon(
                  Icons.clear,
                  color: Colors.blueGrey, // Custom color
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
