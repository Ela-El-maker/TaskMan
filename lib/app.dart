import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:zero002/controllers/newTaskController.dart';
import 'package:zero002/routes/PageRoute.dart';

import 'controllers/DarkThemeController.dart';
import 'controllers/acncelledTaskController.dart';
import 'controllers/authenticationController.dart';
import 'controllers/completedTaskController.dart';
import 'controllers/loginController.dart';
import 'controllers/progressTaskController.dart';
import 'screens/LoginScreens/splashScreen.dart';
import 'widgets/themeServicesPage.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigationKey,
      initialRoute: '/',
      getPages: Routes.routes,
      home: SplashScreen(),
      builder: EasyLoading.init(),
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          textTheme: TextTheme(
              titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          )),
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10)))),
          darkTheme: ThemeData.dark(),
          themeMode:  ThemeServices().theme,
      initialBinding: ControllerBinder(),
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    //Get.put(AuthController());
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(ProgressTaskController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
    Get.put(ThemeController());
  }
}
  
//   @override
//   void dependencies() {
//     // TODO: implement dependencies
//   }
// }