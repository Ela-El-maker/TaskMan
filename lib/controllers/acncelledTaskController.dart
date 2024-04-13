import 'package:get/get.dart';
import 'package:zero002/models/TaskModels/taskCountModel.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTask = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCancelledTask => _getCancelledTask;

  TaskListModel get taskListModel => _taskListModel;

  
}
