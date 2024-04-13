import 'package:get/get.dart';

class TaskController extends GetxController {
  var taskList = [].obs;

  updateTaskList(list) {
    taskList.value = list;
    
  }
}
