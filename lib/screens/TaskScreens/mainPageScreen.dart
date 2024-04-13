// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:zero002/screens/MoreScreens/settingScreen.dart';
// import 'package:zero002/screens/TaskScreens/cancelledScreen.dart';
// import 'package:zero002/screens/TaskScreens/completedScreen.dart';
// import 'package:zero002/screens/TaskScreens/inProgressScreen.dart';
// import 'package:zero002/screens/TaskScreens/newPage.dart';
// import 'package:zero002/widgets/background.dart';

// import '../../controllers/DarkThemeController.dart';
// import '../../controllers/loginController.dart';
// import '../ProfileScreens/profileTab.dart';

// class MainBottomNavScreen extends StatefulWidget {
//   MainBottomNavScreen({super.key});
//   LoginController loginController = Get.put(LoginController());
//   @override
//   State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
// }

// late bool dark;
// final ThemeController themeController = Get.find();

// class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
//   @override
//   void initState() {
//     super.initState();
//     dark = false;
//   }

//   int _selectedIndex = 0;

//   // final List<Widget> _screens = [
//   //   // Provide widgets for each screen
//   //   Placeholder(), // Placeholder for 'New'
//   //   Placeholder(), // Placeholder for 'In Progress'
//   //   Placeholder(), // Placeholder for 'Completed'
//   //   Placeholder(), // Placeholder for 'Canceled'
//   // ];
//   final List<Widget> _screens = [
//     // Widget for 'New' screen
//     NewScreen(),

//     // Widget for 'In Progress' screen
//     ProgressScreen(),

//     // Widget for 'Completed' screen
//     CompletedScreen(),

//     // Widget for 'Cancelled' screen
//     SettingsOnePage(),
//   ];

//   Brightness getBrightness() {
//     return dark ? Brightness.dark : Brightness.light;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//           brightness: getBrightness(),
//           appBarTheme: AppBarTheme(
//               centerTitle: true,
//               toolbarHeight: 100,
//               shadowColor: Colors.yellowAccent,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50)))),
//       child: Scaffold(
//         backgroundColor: dark ? null : Colors.grey.shade200,
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           elevation: 0,
//           toolbarHeight: 100,
//           automaticallyImplyLeading: false,
//           systemOverlayStyle:
//               dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
//           iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
//           backgroundColor: Colors.transparent,
//           // Make app bar transparent
//           //title: ProfileTab(),
//           title: ProfileTab(),
//           //centerTitle: true,

//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(FontAwesomeIcons.moon),
//               onPressed: () {
//                 setState(() {
//                   dark = !dark;
//                 });

//                 themeController.toggleDarkMode();
//               },
//             )
//           ],
//         ),
//         body: _screens[_selectedIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _selectedIndex,
//           onTap: (index) {
//             _selectedIndex = index;
//             setState(() {});
//           },
//           selectedItemColor: Colors.purple,
//           unselectedItemColor: Colors.grey,
//           showSelectedLabels: true,
//           type: BottomNavigationBarType.fixed,
//           items: [
//             BottomNavigationBarItem(
//                 icon: Icon(CupertinoIcons.square_list), label: 'New'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.change_circle_outlined), label: 'Pending'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.done_all_rounded), label: 'Completed'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.settings), label: 'Settings'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zero002/screens/MoreScreens/settingScreen.dart';
import 'package:zero002/screens/TaskScreens/cancelledScreen.dart';
import 'package:zero002/screens/TaskScreens/completedScreen.dart';
import 'package:zero002/screens/TaskScreens/inProgressScreen.dart';
import 'package:zero002/screens/TaskScreens/newPage.dart';
import 'package:zero002/widgets/background.dart';

import '../../controllers/DarkThemeController.dart';
import '../../controllers/loginController.dart';
import '../../widgets/themeServicesPage.dart';
import '../ProfileScreens/profileTab.dart';

class MainBottomNavScreen extends StatefulWidget {
  MainBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

late bool dark;
final ThemeController themeController = Get.find();

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  @override
  void initState() {
    super.initState();
    dark = false;
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    NewScreen(),
    ProgressScreen(),
    CompletedScreen(),
    SettingsOnePage(),
  ];

  Brightness getBrightness() {
    return dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: getBrightness(),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          toolbarHeight: 100,
          shadowColor: Colors.pink[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: dark ? null : Colors.grey.shade200,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Colors.transparent,
            ),
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle:
                  dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
              iconTheme: IconThemeData(
                color: dark ? Colors.white : Colors.black,
              ),
              backgroundColor: Colors.transparent,
              title: ProfileTab(),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    // FontAwesomeIcons.moon,
                    Get.isDarkMode
                        ? Icons.wb_sunny_outlined
                        : Icons.nightlight_round,
                    size: 20,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    // setState(() {
                    //   dark = !dark;
                    // });
                    ThemeServices().switchTheme();
                  },
                )
              ],
            ),
          ),
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            _selectedIndex = index;
            setState(() {});
          },
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_list),
              label: 'New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.change_circle_outlined),
              label: 'Pending',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done_all_rounded),
              label: 'Completed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
