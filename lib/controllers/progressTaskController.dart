import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zero002/controllers/taskController.dart';
import 'package:zero002/models/TaskModels/taskCountModel.dart';

import 'loginController.dart';

class ProgressTaskController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  TaskController taskController = Get.put(TaskController());
  bool _getProgressTask = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getProgressTask => _getProgressTask;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getProgressTaskList() async {
    _getProgressTask = true;
    update();
    try {
      http.Response response;
      response = await http.get(Uri.parse(
          'http://testflutter.felixeladi.co.ke/TaskManager/getInprogressTask.php?username=${loginController.username.value}')); // Replace 'https://example.com/read.php' with your actual endpoint

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
          //update();
          taskController.taskList.value;
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
      _getProgressTask = false;
      update(); // Notify listeners that the state has changed
    }
    return false; // Return false if fetching fails
  }


  Future<void> deleteTask(taskId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://testflutter.felixeladi.co.ke/TaskManager/deleteTask.php?id=$taskId'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          // Task deleted successfully
          print('Deleted Successfully');
        } else {
          // Error deleting task
          print('Error deleting task: ${jsonData['error']}');
        }
      } else {
        // Server returned an error status code
        print('Error deleting task: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during request
      print('Error deleting task: $e');
    }
  }
}
