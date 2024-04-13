import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zero002/controllers/loginController.dart';
import 'package:zero002/controllers/taskController.dart';
import 'package:zero002/widgets/cards.dart';
import 'package:http/http.dart' as http;
import '../../widgets/background.dart';
import '../../widgets/inputField.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key});
  TaskController taskController = Get.put(TaskController());
  LoginController loginController = Get.put(LoginController());
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _subjectTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = '00.00 AM';
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
  int _selectedColor = 0;
  bool _createdTasks = false;
  bool newTaskAdded = false;
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
                              style: Theme.of(context).textTheme.titleLarge,
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
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: InputFieldForm(
                            //         hintText: _startTime,
                            //         widget: IconButton(
                            //           onPressed: () {
                            //             _selectTaskTime(isStartTime: true);
                            //           },
                            //           icon: Icon(
                            //             Icons.access_time_sharp,
                            //             size: 30,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 12,
                            //     ),
                            //     Expanded(
                            //       child: InputFieldForm(
                            //         hintText: _endTime,
                            //         widget: IconButton(
                            //           onPressed: () {
                            //             _selectTaskTime(isStartTime: false);
                            //           },
                            //           icon: Icon(
                            //             Icons.access_time_sharp,
                            //             size: 30,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
                            SizedBox(
                              height: 16,
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
                                            updateTask();
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
          _startTime = _formattedTime;
        });
      } else {
        setState(() {
          _endTime = _formattedTime;
        });
      }
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(':')[0]),
        minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
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

  Future<void> updateTask() async {
    http.Response response;
    // Extract the data from the form fields
    String title = _subjectTextEditingController.text.trim();
    String description = _descriptionTextEditingController.text.trim();
    String date = DateFormat('yyyy-MM-dd')
        .format(_selectedDate); // Format the date as 'yyyy-MM-dd'

    String status = 'New';
    String username = loginController
        .username.value; // Assuming this is the username of the logged-in user

    // Prepare the request body
    Map<String, String> body = {
      'id': '${taskController.taskList.value}',
      'title': title,
      'description': description,
      //'status': 'Completed',
      'date': date,
      'status': status,
      'username': username,
    };

    // Send the PUT request to update the task
    try {
      response = await http.post(
        Uri.parse(
            "http://testflutter.felixeladi.co.ke/TaskManager/updateTask.php"), // Replace with your actual backend URL
        body: body,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var success = serverResponse['success'];
        if (success == 1) {
          print('Task Created');
          Get.back(); // Close the current screen if task creation is successful
          newTaskController
              .getNewTaskList(); // Assuming newTaskController is correctly defined
        }
        // Task updated successfully
        print('Task updated successfully');
        // You may handle further actions here, such as navigating back to the previous screen
      } else {
        // Failed to update the task
        print('Failed to update task. Status code: ${response.statusCode}');
        // You may display an error message to the user
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print('Error updating task: $e');
      // You may display an error message to the user
      Get.snackbar(
        'Error',
        'Failed to update task. Please try again later.',
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
