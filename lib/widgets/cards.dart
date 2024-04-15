import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart' as easyloading;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:zero002/controllers/completedTaskController.dart';
import 'package:zero002/controllers/newTaskController.dart';
import 'package:zero002/controllers/progressTaskController.dart';
import 'package:zero002/models/userModel.dart';
import 'package:zero002/screens/TaskScreens/editTaskScreen.dart';
import 'package:zero002/screens/TaskScreens/taskDetailsScreen.dart';

import '../constants/colors.dart';
import '../controllers/loginController.dart';
import '../controllers/taskController.dart';
import '../models/TaskModels/taskCountModel.dart';
import '../screens/TaskScreens/addNewTask.dart';
import '../screens/TaskScreens/mainPageScreen.dart';
import 'customAnimation.dart';

enum TaskStatus {
  New,
  Pending,
  Completed,
}

void configLoading() {
  easyloading.EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = easyloading.EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = easyloading.EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class SummaryCard extends StatelessWidget {
  final String count;
  final String title;

  const SummaryCard({
    Key? key,
    required this.count,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
        child: Column(
          children: [
            Text(
              count,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class TaskItemCard extends StatefulWidget {
  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  const TaskItemCard({
    Key? key,
    required this.task,
    required this.onStatusChange,
    required this.showProgress,
  }) : super(key: key);

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

LoginController loginController = Get.put(LoginController());
TaskController taskController = Get.put(TaskController());
NewTaskController newTaskController = Get.put(NewTaskController());
ProgressTaskController progressTaskController =
    Get.put(ProgressTaskController());

CompletedTaskController completedTaskController =
    Get.put(CompletedTaskController());

class _TaskItemCardState extends State<TaskItemCard> {
  // Future<void> updateTaskStatus(String status, Task task) async {
  //   widget.showProgress(true);

  //   widget.showProgress(false);
  // }
  @override
  void initState() {
    super.initState();
    Get.find<NewTaskController>().getNewTaskList();
    //getTaskCountList();
    dark = false;
  }

  Brightness _getBrightness() {
    return dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return SlideTransition(
                  position: Tween(
                    begin: Offset(0.0, 1.0), // Slide up from bottom
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              pageBuilder: (
                context,
                animation,
                secondaryAnimation,
              ) {
                // Define a function to build the dialog widget
                Widget _buildDialogWidget(BuildContext context) {
                  return Stack(children: [
                    //Background content

                    Positioned.fill(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    )),

                    Center(
                      child: AnimatedDialog(
                        duration:
                            Duration(seconds: 10), // Slow animation duration
                        curve: Curves.easeInOut, // Animation curve
                        child: AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          content: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16),
                                    Text(
                                      'Task Information',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          16.0, // Adjust the height as needed
                                      child: Divider(
                                        height: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      color: dark
                                          ? Colors.grey[900]
                                          : Colors.blue[
                                              100], // Use dark background color
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Task ID:',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.indigo,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              widget.task.id ?? '',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Task Title:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      widget.task.title ?? '',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Task Description:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      widget.task.description ?? '',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    SizedBox(height: 8),
                                    Chip(
                                      label: Text(
                                        widget.task.status ?? 'New',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.indigo[100],
                                    ),
                                    SizedBox(height: 8),
                                    Chip(
                                      label: Text(
                                        widget.task.date ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      backgroundColor:
                                          const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Add your edit logic here
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            EditTaskScreen())));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Add your delete logic here
                                showDeleteStatusModal(context);
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Dismiss the dialog
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
                }

                // Return the function that builds the dialog widget
                return _buildDialogWidget(context);
              },
            ),
          );
        },
        child: Card(
          // color: dark
          //     ? Colors.grey[900]
          //     : Colors.purple[100], // Use dark background color
          color: getColorByIndex(widget.task?.color ?? 0),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //       padding: EdgeInsets.all(16),
              // //  width: SizeConfig.screenWidth * 0.78,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(16),
              //   color: _getBGClr(widget.task?.color??0),
              // ),
              children: [
                Text(
                  'Task ID : ' + widget.task.id!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color:
                        dark ? Colors.white : Colors.black, // Adjust text color
                  ),
                ),
                Divider(color: dark ? Colors.white : Colors.black),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.task.title ?? '',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: dark ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.task.description ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    color: dark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Divider(color: dark ? Colors.white : Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'From : ' + (widget.task.startTime ?? ''),
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(221, 220, 10, 6),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'To : ' + (widget.task.dueTime ?? ''),
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(221, 220, 10, 6),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                //Text('Date: ${formattedDateTime(widget.task.createdAt ?? '')}'),
                Divider(color: dark ? Colors.white : Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(
                        widget.task.status ?? 'New',
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black),
                      ),
                      backgroundColor: _getChipColor(widget.task.status),
                    ),
                    Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            showUpdateStatusModal(context, widget.task);
                          },
                          icon: Icon(
                            Icons.mode_edit_outlined,
                            size: 25,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // //var easyloading;
                            // easyloading.EasyLoading.show(
                            //   // Using the alias
                            //   status: 'Sorry',
                            // );
                            // Future.delayed(Duration(seconds: 2), () {
                            //   easyloading.EasyLoading
                            //       .dismiss(); // Dismiss the loading indicator
                            // });

                            showDeleteStatusModal(context);
                          },
                          icon: Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(color: dark ? Colors.white : Colors.black),
                Text(
                  'Date : ' + (widget.task.date ?? ''),
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(221, 154, 220, 12),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return blueColor;
      case 1:
        return pinkColor;
      case 2:
        return yellowColor;
      default:
        return tealColor;
    }
  }

  Color getColorByIndex(int index) {
    switch (index) {
      case 0:
        return limeColor;
      case 1:
        return azureGlassColor;
      case 2:
        return roseGlassColor;
      case 3:
        return indigoColor;
      case 4:
        return amberColor; // Add the fifth color
      case 5:
        return tealColor; // Add the sixth color
      case 6:
        return turquoiseGlassColor;
      default:
        return Colors.transparent;
    }
  }

  Color _getChipColor(String? status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.indigo;
    }
  }

  void showUpdateStatusModal(BuildContext context, Task? task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Task Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: TaskStatus.values.map((status) {
              return ListTile(
                leading: _buildStatusIcon(status),
                title: Text(status.toString().split('.').last),
                onTap: () {
                  updateTaskStatus(context, task!, status);
                  newTaskController.getNewTaskList();
                  progressTaskController.getProgressTaskList();
                  completedTaskController.getCompletedTaskList();
                },
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void updateTaskStatus(BuildContext context, Task task, TaskStatus newStatus) {
    // Perform the update task status operation here
    newTaskController.updateStatusTask(
        task.id, newStatus.toString().split('.').last);
    Fluttertoast.showToast(
      msg: 'Task status updated to ${newStatus.toString().split('.').last}',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Navigator.of(context).pop();
    newTaskController.getNewTaskList();
  }

  Widget _buildStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.New:
        return Icon(
          Icons.fiber_new,
          color: Colors.orange,
        );
      case TaskStatus.Pending:
        return Icon(
          Icons.timer,
          color: Colors.blue,
        );
      case TaskStatus.Completed:
        return Icon(
          Icons.playlist_add_check_circle_outlined,
          color: Colors.green,
        );
      default:
        return SizedBox(); // Return an empty sizedbox for unknown status
    }
  }

  void showDeleteStatusModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Delete Task',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Are you sure you want to delete this task?"),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                // Dismiss the dialog and return true
                newTaskController.getNewTaskList();
                progressTaskController.getProgressTaskList();
                progressTaskController.deleteTask(widget.task.id);
                completedTaskController.getCompletedTaskList();
                completedTaskController.deleteTask(widget.task.id);
                newTaskController.deleteTask(widget.task.id);
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.check_circle_outlined,
                color: Colors.red,
              ),
              label: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(
                    context, false); // Dismiss the dialog return false
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              label: Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AnimatedDialog extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedDialog({
    required this.child,
    required this.duration,
    required this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}

String formattedDateTime(String? createdAt) {
  try {
    if (createdAt != null && createdAt.isNotEmpty) {
      DateTime dateTime = DateTime.parse(createdAt);
      String formattedDate = DateFormat('EEE, MMM d').format(dateTime);
      String formattedTime = DateFormat('hh:mm a').format(dateTime);
      return '$formattedDate at $formattedTime';
    } else {
      return 'No Date';
    }
  } catch (e) {
    print('Error parsing date: $e');
    return 'Invalid Date';
  }
}
