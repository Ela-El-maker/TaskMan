import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zero002/models/TaskModels/taskCountModel.dart';

import 'loginController.dart';

class CompletedTaskController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  bool _getCompletedTask = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCompletedTask => _getCompletedTask;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCompletedTaskList() async {
    bool success = false;
    _getCompletedTask = true;
    update();
    try {
      // Make HTTP GET request to fetch tasks from server
      final response = await http.get(Uri.parse(
          'http://testflutter.felixeladi.co.ke/TaskManager/getCompletedTask.php?username=${loginController.username.value}')); // Replace 'https://example.com/read.php' with your actual endpoint

      if (response.statusCode == 200) {
        // Parse JSON response
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          // Parse task data from JSON
          List<Task> tasks = (jsonData['tasks'] as List)
              .map((taskJson) => Task.fromJson(taskJson))
              .toList();
          _taskListModel = TaskListModel(
            status: 'success',
            taskList: tasks,
          );
          update();
          return true; // Return true if fetching is successful
        } else {
          print('Error fetching tasks: ${jsonData['error']}');
        }
      } else {
        print('Error fetching tasks: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching new tasks: $e");
    } finally {
      _getCompletedTask = false;
      update(); // Notify listeners that the state has changed
    }
    return success; // Return false if fetching fails
  }
}
