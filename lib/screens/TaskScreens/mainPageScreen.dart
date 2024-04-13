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

late bool dark;
final ThemeController themeController = Get.find();

class MainBottomNavScreen extends StatefulWidget {
  MainBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

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

// void toggleTheme() {
//     setState(() {
//       themeMode =
//           themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//     });
//   }
  void toggleTheme() {
    themeController.toggleDarkMode();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      dark = themeController.isDarkMode.value;
      return Theme(
        data: ThemeData(
          brightness: dark ? Brightness.dark : Brightness.light,
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
          appBar: AppBar(
            title: ProfileTab(),
            leading: IconButton(
              icon: Icon(dark ? Icons.nightlight_round : Icons.wb_sunny),
              onPressed: toggleTheme,
            ),
            elevation: 0,
            automaticallyImplyLeading: false,
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
    });
  }
}
