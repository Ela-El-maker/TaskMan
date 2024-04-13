import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zero002/constants/colors.dart';
import 'package:zero002/controllers/completedTaskController.dart';
import 'package:zero002/screens/ProfileScreens/profileTab.dart';
import 'package:zero002/widgets/background.dart';
import 'package:zero002/widgets/cards.dart';

import '../../controllers/completedTaskController.dart';
import '../../models/TaskModels/taskCountModel.dart';
import 'mainPageScreen.dart';
import 'newPage.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  bool getTaskCountInProgress = false;
  TaskCountListModel taskCountSummaryListModel = TaskCountListModel();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    Get.find<CompletedTaskController>().getCompletedTaskList();
    dark = false;
  }

  Brightness _getBrightness() {
    return dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _todayDate(),
            //_addDateBar(),
            //ProfileTab(),
            //Icon(Icons.check_box_outlined, size: 100, color: Colors.green),
            //SizedBox(height: 20),
            Expanded(child: GetBuilder<CompletedTaskController>(
                builder: (completedTaskController) {
              return Visibility(
                visible: completedTaskController.getCompletedTask == false,
                replacement: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //CircularProgressIndicator(),
                      Text(
                        'No tasks found!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the action when the button is pressed, like refreshing the tasks list
                          CircularProgressIndicator();
                          completedTaskController.getCompletedTaskList();
                        },
                        child: Text('Refresh'),
                      ),
                    ],
                  ),
                ),
                child: RefreshIndicator(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: completedTaskController
                              .taskListModel.taskList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: completedTaskController
                              .taskListModel.taskList![index],
                          onStatusChange: () {
                            completedTaskController.getCompletedTaskList();
                          },
                          showProgress: (inProgress) {},
                        );
                      }),
                  onRefresh: () =>
                      completedTaskController.getCompletedTaskList(),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }

  _todayDate() {
    final now = DateTime.now();
    final selectedDate = _selectedDate ?? now;

    String dateString;
    if (selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day) {
      dateString = 'Today';
    } else if (selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day + 1) {
      dateString = 'Tomorrow';
    } else {
      dateString = DateFormat('EEE').format(selectedDate);
    }
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(selectedDate),
                          style: subHeadings,
                        ),
                        Text(dateString, style: headingStyle),
                        // Define the icon to be displayed based on your requirements
                      ]),
                ),
                // Icon(
                //   Icons.new_releases_outlined,
                //   color: Colors.blue,
                //   size: 100,
                // ),
                //_addDateBar(),
              ],
            ),
          ),
        ),
        Expanded(
          child: _addDateBar(),
        )
      ],
    );
  }

  _addDateBar() {
    return Container(
      //color: Colors.black54,
      margin: EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 70,
        initialSelectedDate: _selectedDate ?? DateTime.now(),
        selectionColor: primaryColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }
}
