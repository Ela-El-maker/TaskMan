import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

// class LoginController extends GetxController {
//   bool _loginInProgress = false;
//   bool get loginInProgress => _loginInProgress;
// }

// class LoginController extends GetxController {
//   var username = ''.obs;

//   updateUsername(String value1) {
//     username.value = value1;
//   }
// }
import 'package:get/get.dart';
import 'package:zero002/screens/MoreScreens/moreScreen.dart';

class LoginController extends GetxController {
  var userID = ''.obs;
  var username = ''.obs;
  var emailAddress = ''.obs;
  var photo = ''.obs; // Add observable variable for photo URL

  updateuserID(var value1) {
    userID.value = value1;
  }

  updateUsername(String value1) {
    username.value = value1;
  }

  updateEmailAddress(String value1) {
    emailAddress.value = value1;
  }

  updatePhoto(var value1) {
    // Add method to update photo URL
    photo.value = value1;
  }

  Future<void> updateUserInfo() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://testflutter.felixeladi.co.ke/TaskManager/updateUser.php'),
        body: {
          // 'id': '${taskId}',
          // 'status': '${status}',
          'username': loginController.username.value,
          'emailAddress': loginController.emailAddress.value,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          // Task updated successfully
          print('Updated User Successfully');
        } else {
          // Error updating task
          print('Error updating User: ${jsonData['error']}');
        }
      } else {
        // Server returned an error status code
        print('Error updating User: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during request
      print('Error updating User: $e');
    }
  }
}
