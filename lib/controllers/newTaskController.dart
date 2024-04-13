import 'package:get/get.dart';
import 'package:zero002/controllers/taskController.dart';
import '../models/TaskModels/taskCountModel.dart'; // Make sure to import your models
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'loginController.dart';

class NewTaskController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  TaskController taskController = Get.put(TaskController());
  bool _getNewTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;
  Future<bool> getNewTaskList() async {
    _getNewTaskInProgress = true;
    
    http.Response response;
    response = await http.get(Uri.parse(
        'http://testflutter.felixeladi.co.ke/TaskManager/getNewTask.php?username=${loginController.username.value}')); // Use username directly from LoginController

    if (response.statusCode == 200) {
      // Parse JSON response
      var jsonData = jsonDecode(response.body);
      var taskResponse = jsonData['tasks'];
      // var taskDrip = taskResponse.map((task) => Task.fromJson(task)).toList();
      // taskController.updateTaskList(taskDrip);

      if (jsonData['success'] == 1) {
        // Parse task data from JSON
        List<Task> tasks = (jsonData['tasks'] as List)
            .map((taskJson) => Task.fromJson(taskJson))
            .toList();
        _taskListModel = TaskListModel(
          status: 'success',
          taskList: tasks,
        );
        //_getNewTaskInProgress = false;

        update(); // Notify listeners that the state has changed
        return true; // Return true if fetching is successful
      } else {
        print('Error fetching tasks: ${jsonData['error']}');
      }
    } else {
      print('Error fetching tasks: ${response.statusCode}');
    }
    //_getNewTaskInProgress = false;

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

  Future<void> updateTask(taskId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://testflutter.felixeladi.co.ke/TaskManager/updateTask.php?id=$taskId'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          // Task deleted successfully
          print('Updated Successfully');
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

  Future<void> updateStatusTask(String? taskId, String? status) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://testflutter.felixeladi.co.ke/TaskManager/updateStatusTask.php?'),
        body: {
          // 'id': '${taskId}',
          // 'status': '${status}',
          'id': '${taskId}',
          'status': '${status}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          // Task updated successfully
          print('Updated Status Successfully');
          print('${taskId}');
          print(status);
          update();
        } else {
          // Error updating task
          print('Error updating Status task: ${jsonData['error']}');
        }
      } else {
        // Server returned an error status code
        print('Error updating Status task: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during request
      print('Error updating Status task: $e');
    }
  }
}
