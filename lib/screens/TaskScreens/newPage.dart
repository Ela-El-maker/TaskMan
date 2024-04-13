import 'dart:ui';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zero002/controllers/newTaskController.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:zero002/screens/ProfileScreens/profile.dart';
import 'package:zero002/screens/ProfileScreens/profileTab.dart';
import 'package:zero002/widgets/background.dart';
import 'package:zero002/widgets/customAnimation.dart';
import '../../constants/colors.dart';
import '../../models/TaskModels/taskCountModel.dart';
import '../../widgets/cards.dart';
import 'addNewTask.dart';
import 'mainPageScreen.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  bool getTaskCountInProgress = false;
  TaskCountListModel taskCountListModel = TaskCountListModel();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Get.find<NewTaskController>().getNewTaskList();

    dark = false;
  }

  Brightness _getBrightness() {
    return dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add onPressed functionality to handle adding new tasks
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => AddNewTaskScreen())));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _todayDate(),
            //_addDateBar(),
            //ProfileTab(),
            // Visibility(
            //   visible: getTaskCountInProgress == false &&
            //       (taskCountListModel.taskCountList?.isNotEmpty ?? false),
            //   //replacement: LinearProgressIndicator(),
            //   // Set visibility to true to display the icon
            //   child: SizedBox(
            //     height: 120,
            //     child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: taskCountListModel.taskCountList?.length ?? 0,
            //         itemBuilder: (context, index) {
            //           TaskCount taskCount =
            //               taskCountListModel.taskCountList![index];
            //           return FittedBox(
            //             child: SummaryCard(
            //               count: taskCount.sum.toString(),
            //               title: taskCount.id ?? '',
            //             ),
            //           );
            //         }),
            //   ),
            // ),
            // Expanded(
            //   child: GetBuilder<NewTaskController>(
            //     builder: (newTaskController) {
            //       return Visibility(
            //           visible: newTaskController.getNewTaskInProgress == false,
            //           replacement: Center(
            //             child: CircularProgressIndicator(),
            //           ),
            //           child:  RefreshIndicator(
            //                   onRefresh: () =>
            //                       newTaskController.getNewTaskList(),
            //                   child: AnimationLimiter(
            //                     child: ListView.builder(
            //                       padding: EdgeInsets.all(_w / 20),
            //                       physics: BouncingScrollPhysics(
            //                           parent: AlwaysScrollableScrollPhysics()),
            //                       itemCount: newTaskController
            //                               .taskListModel.taskList?.length ??
            //                           0,
            //                       itemBuilder: (context, index) {
            //                         return AnimationConfiguration.staggeredList(
            //                           position: index,
            //                           delay: Duration(milliseconds: 100),
            //                           child: SlideAnimation(
            //                             duration: Duration(milliseconds: 2500),
            //                             curve: Curves.fastLinearToSlowEaseIn,
            //                             verticalOffset: -250,
            //                             child: TaskItemCard(
            //                                 task: newTaskController
            //                                     .taskListModel.taskList![index],
            //                                 onStatusChange: () {
            //                                   newTaskController
            //                                       .getNewTaskList();
            //                                   setState(() {});
            //                                 },
            //                                 showProgress: (inProgress) {}),
            //                           ),
            //                         );
            //                       },
            //                     ),

            //                   ),
            //                 ));
            //     },
            //   ),
            // ),

            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.getNewTaskInProgress == false,
                    replacement: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No tasks found!',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Handle the action when the button is pressed, like refreshing the tasks list
                              newTaskController.getNewTaskList();
                            },
                            child: Text('Refresh'),
                          ),
                        ],
                      ),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () => newTaskController.getNewTaskList(),
                      child: AnimationLimiter(
                        child: ListView.builder(
                          padding: EdgeInsets.all(_w / 20),
                          physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          itemCount: newTaskController
                                  .taskListModel.taskList?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              delay: Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                verticalOffset: -250,
                                child: TaskItemCard(
                                  task: newTaskController
                                      .taskListModel.taskList![index],
                                  onStatusChange: () {
                                    newTaskController.getNewTaskList();
                                    setState(() {});
                                  },
                                  showProgress: (inProgress) {},
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
