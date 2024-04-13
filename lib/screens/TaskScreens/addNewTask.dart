import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zero002/controllers/taskController.dart';
import 'package:zero002/models/TaskModels/taskCountModel.dart';
import 'package:zero002/widgets/background.dart';
import 'package:zero002/widgets/cards.dart';
import 'package:zero002/widgets/inputField.dart';

import '../../constants/colors.dart';
import '../../controllers/loginController.dart';
import 'mainPageScreen.dart';
// main.dart
//import 'package:decorated_icon/cupertino_will_pop_scope.dart';

class AddNewTaskScreen extends StatefulWidget {
  //Task? task; // Add a Task object as a parameter
  TaskController taskController = Get.put(TaskController());
  AddNewTaskScreen(
      {
      // required this.task,
      Key? key})
      : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();

  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String endTime = '00.00 AM';
  int _selectedReminder = 5;
  List<int> reminderList = [
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    55,
    60,
  ];
  String _selectedRepeat = 'None';
  List<String> repeaterList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
  ];
  int selectedColor = 0;
  bool _createdTasks = false;
  bool newTaskAdded = false;
  Task task = Task();
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, newTaskAdded);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Text(
                              'Add new Task',
                              //style: Theme.of(context).textTheme.titleLarge,
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                                color: dark ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _subjectTextEditingController,
                              decoration:
                                  InputDecoration(hintText: 'Subject'),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return 'Your Subject';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _descriptionTextEditingController,
                              decoration:
                                  InputDecoration(hintText: 'Description'),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return 'Your Description';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            InputFieldForm(
                              hintText:
                                  DateFormat.yMd().format(_selectedDate),
                              widget: IconButton(
                                  onPressed: () {
                                    _selectTaskDate();
                                  },
                                  icon: Icon(
                                    Icons.calendar_month_sharp,
                                    size: 45,
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InputFieldForm(
                                    hintText: startTime,
                                    widget: IconButton(
                                      onPressed: () {
                                        _selectTaskTime(isStartTime: true);
                                      },
                                      icon: Icon(
                                        Icons.access_time_sharp,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: InputFieldForm(
                                    hintText: endTime,
                                    widget: IconButton(
                                      onPressed: () {
                                        _selectTaskTime(isStartTime: false);
                                      },
                                      icon: Icon(
                                        Icons.access_time_sharp,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // InputFieldForm(
                            //   hintText: '$_selectedReminder minutes early',
                            //   widget: DropdownButton<int>(
                            //     icon: Icon(
                            //       Icons.keyboard_double_arrow_down_outlined,
                            //     ),
                            //     iconSize: 32,
                            //     elevation: 4,
                            //     onChanged: (int? value) {
                            //       setState(() {
                            //         _selectedReminder = value!;
                            //       });
                            //     },
                            //     items: reminderList
                            //         .map<DropdownMenuItem<int>>((int value) {
                            //       return DropdownMenuItem(
                            //         value: value,
                            //         child: Text(value.toString()),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // InputFieldForm(
                            //   hintText: '$_selectedRepeat',
                            //   widget: DropdownButton<String>(
                            //     icon: Icon(
                            //       Icons.keyboard_double_arrow_down_outlined,
                            //     ),
                            //     iconSize: 32,
                            //     elevation: 4,
                            //     onChanged: (String? value1) {
                            //       setState(() {
                            //         _selectedRepeat = value1!;
                            //       });
                            //     },
                            //     items: repeaterList
                            //         .map<DropdownMenuItem<String>>(
                            //             (String value) {
                            //       return DropdownMenuItem(
                            //         value: value,
                            //         child: Text(
                            //           value.toString(),
                            //         ),
                            //       );
                            //     }).toList(),
                            //     value: _selectedRepeat,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 16,
                            // ),
                            Row(
                              children: [
                                colorPallete(),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Visibility(
                                visible: _createdTasks == false,
                                replacement: Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(Icons
                                              .arrow_back_ios_new_sharp)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            addTask(); // Access userId from widget.task
                                          },
                                          child:
                                              Icon(Icons.arrow_circle_right)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectTaskDate() async {
    DateTime? _pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2222),
    );
    if (_pickDate != null) {
      setState(() {
        _selectedDate = _pickDate!;
        print(_selectedDate);
      });
    } else {
      print('No date selected. Somethingwent wrong!!!');
    }
  }

  _selectTaskTime({required bool isStartTime}) async {
    var pickTime = await _showTimePicker();
    if (pickTime == null) {
      print('Time Cancelled');
    } else {
      String _formattedTime = pickTime.format(context);
      if (isStartTime) {
        setState(() {
          startTime = _formattedTime;
        });
      } else {
        setState(() {
          endTime = _formattedTime;
        });
      }
    }
  }

  // colorPallete() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       SizedBox(
  //         height: 8.0,
  //       ),
  //       Wrap(
  //         children: List<Widget>.generate(3, (int index) {
  //           return GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 _selectedColor = index;
  //               });
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.only(right: 8.0),
  //               child: CircleAvatar(
  //                   radius: 20,
  //                   backgroundColor: index == 0
  //                       ? limeColor
  //                       : index == 1
  //                           ? azureGlassColor
  //                           : index == 2
  //                               ? roseGlassColor
  //                               : indigoColor,
  //                   child: _selectedColor == index
  //                       ? Icon(
  //                           Icons.done,
  //                           color: Colors.white,
  //                           size: 16,
  //                         )
  //                       : Container()),
  //             ),
  //           );
  //         }),
  //       ),
  //       SizedBox(
  //         height: 10,
  //       )
  //     ],
  //   );
  // }
  Widget colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(6, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: getColorByIndex(index),
                  child: selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
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

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(startTime.split(':')[0]),
        minute: int.parse(startTime.split(':')[1].split(' ')[0]),
      ),
    );
  }

  validateFieldForms() {
    if (_subjectTextEditingController.text.isNotEmpty &&
        _descriptionTextEditingController.text.isNotEmpty) {
      Get.back();
    } else if (_subjectTextEditingController.text.isEmpty ||
        _descriptionTextEditingController.text.isEmpty) {
      Get.snackbar(
        'All fields required.',
        'Required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.warning_amber_sharp,
          color: Colors.white,
        ),
        colorText: Colors.black26,
      );
    }
  }

  // Future<void> addTask() async {
  //   http.Response response;
  //   var body = {
  //     'title': _subjectTextEditingController.text.trim(),
  //     'description': _descriptionTextEditingController.text.trim(),
  //     'date': DateFormat.yMd().format(_selectedDate),
  //     // 'taskStartDate': _startTime,
  //     // 'taskDueDate': _endTime,
  //     // 'taskRepeatMode': _selectedRepeat,
  //     // 'taskReminderTime': _selectedReminder.toString(),
  //     // 'taskColor': _selectedColor,
  //     'status': 'New',
  //     'user_id': '1'
  //   };
  //   response = await http.post(
  //       Uri.parse(
  //           "http://testflutter.felixeladi.co.ke/TaskManager/readTask.php"),
  //       body: body);

  //   if (response.statusCode == 200) {
  //     var serverResponse = json.decode(response.body);
  //     int signedUp = serverResponse['success'];
  //     if (signedUp == 1) {
  //       print('Task Created');
  //       Get.back();
  //     }
  //   }
  // }
//   Future<void> addTask() async {
//     http.Response response;
//     var body = {
//       'title': _subjectTextEditingController.text.trim(),
//       'description': _descriptionTextEditingController.text.trim(),
//       'date': DateFormat.yMd().format(_selectedDate),
//       'status': 'New',
//       'username':
//           '${loginController.username.value}', // Replace 'your_user_id_here' with the actual user ID
//     };

// print(DateFormat.yMd().format(_selectedDate));
//     // Ensure that all required fields are filled before making the request
//     if (_subjectTextEditingController.text.trim().isEmpty ||
//         _descriptionTextEditingController.text.trim().isEmpty) {
//       // Show an error message indicating that all fields are required
//       Get.snackbar(
//         'All fields required.',
//         'Required',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         icon: Icon(
//           Icons.warning_amber_sharp,
//           color: Colors.white,
//         ),
//         colorText: Colors.black26,
//       );
//       return; // Exit the method early if any field is empty
//     }

//     // Send the POST request
//     response = await http.post(
//       Uri.parse(
//           "http://testflutter.felixeladi.co.ke/TaskManager/createTask.php"),
//       body: body,
//     );

//     // Print the response body for debugging
//     print('Response body: ${response.body}');

//     // Process the response
//     if (response.statusCode == 200) {
//       var serverResponse = json.decode(response.body);
//       var signedUp = serverResponse['success'];
//       if (signedUp == 1) {
//         print('Task Created');
//         Get.back(); // Close the current screen if task creation is successful
//         newTaskController.getNewTaskList();
//       }
//     }
//   }
  // Future<void> addTask() async {
  //   http.Response response;

  //   // Extracting the data from the form fields
  //   String title = _subjectTextEditingController.text.trim();
  //   String description = _descriptionTextEditingController.text.trim();
  //   String date = DateFormat('yyyy-MM-dd')
  //       .format(_selectedDate); // Format the date as 'yyyy-MM-dd'
  //   String status = 'New';
  //   String username = loginController
  //       .username.value; // Assuming this is the username of the logged-in user

  //   // Prepare the request body
  //   Map<String, String> body = {
  //     'title': title,
  //     'description': description,
  //     'date': date,
  //     'status': status,
  //     'username': username,
  //   };

  //   // Ensure that all required fields are filled before making the request
  //   if (title.isEmpty || description.isEmpty) {
  //     // Show an error message indicating that all fields are required
  //     Get.snackbar(
  //       'All fields required.',
  //       'Required',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       icon: Icon(
  //         Icons.warning_amber_sharp,
  //         color: Colors.white,
  //       ),
  //       colorText: Colors.black26,
  //     );
  //     return; // Exit the method early if any field is empty
  //   }

  //   try {
  //     // Send the POST request
  //     response = await http.post(
  //       Uri.parse(
  //           "http://testflutter.felixeladi.co.ke/TaskManager/createTask.php"),
  //       body: body,
  //     );

  //     // Print the response body for debugging
  //     print('Response body: ${response.body}');

  //     // Process the response
  //     if (response.statusCode == 200) {
  //       var serverResponse = json.decode(response.body);
  //       var success = serverResponse['success'];
  //       if (success == 1) {
  //         print('Task Created');

  //         // var taskData = serverResponse['data'];
  //         // print(taskData);
  //         // var taskid = taskData[0]['id'];
  //         // var tasktitle = taskData[0]['title'];
  //         // print(tasktitle);
  //         // Print all columns of the created task
  //         //print('Created Task: ${serverResponse['data']}');
  //         // Check if 'data' key exists and is not null
  //         if (serverResponse.containsKey('data') &&
  //             serverResponse['data'] != null) {
  //           var taskData = serverResponse['data'];
  //           print(taskData);
  //           var taskid = taskData[0]['id'];
  //           var tasktitle = taskData[0]['title'];
  //           print(tasktitle);
  //           // Print all columns of the created task
  //           print('Created Task: ${serverResponse['data']}');
  //         } else {
  //           print('No task data found in the response');
  //         }
  //         Get.back(); // Close the current screen if task creation is successful
  //         newTaskController
  //             .getNewTaskList(); // Assuming newTaskController is correctly defined
  //       }
  //     } else {
  //       throw Exception('Failed to create task: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle any errors that occur during the HTTP request
  //     print('Error creating task: $e');
  //     Get.snackbar(
  //       'Error',
  //       'Failed to create task. Please try again later.',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       icon: Icon(
  //         Icons.error_outline,
  //         color: Colors.white,
  //       ),
  //       colorText: Colors.black26,
  //     );
  //   }
  // }
  Future<void> addTask() async {
    http.Response response;

    // Extracting the data from the form fields
    String title = _subjectTextEditingController.text.trim();
    String description = _descriptionTextEditingController.text.trim();
    String date = DateFormat('yyyy-MM-dd')
        .format(_selectedDate); // Format the date as 'yyyy-MM-dd'
    String status = 'New';
    String username = loginController
        .username.value; // Assuming this is the username of the logged-in user

    // String startTime = startTime,
    // String dueTime = endTime,
    // int color = selectedColor,

    // Prepare the request body
    Map<String, String> body = {
      'title': title,
      'description': description,
      'date': date,
      'status': status,
      'username': username,
      'startTime': startTime, // Add startTime to the request body
      'dueTime': endTime, // Add dueTime to the request body
      'color': selectedColor
          .toString(), // Convert color to String and add it to the request body
    };

    // Ensure that all required fields are filled before making the request
    if (title.isEmpty || description.isEmpty) {
      // Show an error message indicating that all fields are required
      Get.snackbar(
        'All fields required.',
        'Required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.warning_amber_sharp,
          color: Colors.white,
        ),
        colorText: Colors.black26,
      );
      return; // Exit the method early if any field is empty
    }

    try {
      // Send the POST request
      response = await http.post(
        Uri.parse(
            "http://testflutter.felixeladi.co.ke/TaskManager/createTask.php"),
        body: body,
      );

      // Print the response body for debugging
      print('Response body: ${response.body}');

      // Process the response
      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var success = serverResponse['success'];
        if (success == 1) {
          print('Task Created');

          var taskData = serverResponse['data'];
          if (taskData != null) {
            var taskId = taskData[0]['id'];
            var taskTitle = taskData[0]['title'];
            print('Task ID: $taskId, Title: $taskTitle');
          } else {
            print('No task data found in the response');
          }
          newTaskController
              .getNewTaskList(); // Assuming newTaskController is correctly defined
          Get.back(); // Close the current screen if task creation is successful
        }
      } else {
        throw Exception('Failed to create task: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print('Error creating task: $e');
      Get.snackbar(
        'Error',
        'Failed to create task. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        colorText: Colors.black26,
      );
    }
  }
}
