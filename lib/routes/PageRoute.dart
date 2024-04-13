import 'package:get/get.dart';
import 'package:zero002/screens/MoreScreens/moreScreen.dart';
import 'package:zero002/screens/MoreScreens/settingScreen.dart';
import 'package:zero002/screens/TaskScreens/mainPageScreen.dart';
import 'package:zero002/screens/TaskScreens/newPage.dart';

import '../screens/LoginScreens/loginScreen.dart';
import '../screens/LoginScreens/signupScreen.dart';

class Routes {
  static var routes = [
    GetPage(name: '/', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/mainScreen', page: () => MainBottomNavScreen()),
    GetPage(name: '/settingScreen', page: () => SettingsOnePage()),
    GetPage(name: '/helpScreen', page: () => MoreScreen()),
    GetPage(name: '/newScreen', page: () => NewScreen())
  ];

  // List<GetPage> routes1 = [
  //   //GetPage(name: '/', page: () => const LoginPage()),
  //   GetPage(name: '/signup', page: () => const SignUpScreen()),
  //   //GetPage(name: '/home', page: () => const MyHomePage()),
  //   //GetPage(name: '/profile', page: () => const MyProfilePage()),
  // ];
}
