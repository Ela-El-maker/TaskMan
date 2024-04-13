import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zero002/controllers/completedTaskController.dart';
import 'package:zero002/screens/ProfileScreens/profileTab.dart';
import 'package:zero002/widgets/background.dart';
import 'package:zero002/widgets/cards.dart';

import '../../constants/colors.dart';
import '../../controllers/acncelledTaskController.dart';
import '../../controllers/completedTaskController.dart';
import '../../models/TaskModels/taskCountModel.dart';
import 'newPage.dart';

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({super.key});

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  bool getTaskCountInProgress = false;
  TaskCountListModel taskCountSummaryListModel = TaskCountListModel();
  DateTime _selectedDate = DateTime.now();

  Future<void> getTaskCountList() async {
    // getTaskCountInProgress = true;
    // if (mounted) {
    //   setState(() {});
    // }
    // getTaskCountInProgress = false;
    // if (mounted) {
    //   setState(() {});
    // }
  }

  // @override
  // void initState() {
  //   Get.find<CancelledTaskController>().getCancelledTaskList();
  //   getTaskCountList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: GlassmorphicContainer(
          width: MediaQuery.of(context).size.width,
          height: 100,
          borderRadius: 30, // Adjust border radius for a more glassy effect
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 46, 150, 152).withOpacity(0.1),
              Color.fromARGB(255, 22, 198, 119).withOpacity(0.05),
            ],
            stops: [
              0.1,
              1,
            ],
          ),
          border: 2,
          blur: 20,
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.5),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Make app bar transparent
            title: ProfileTab(),
            centerTitle: true,
            elevation: 0, // Remove app bar shadow
            actions: [],
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add onPressed functionality to handle adding new tasks
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: BodyBackground(
        child: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _todayDate(),
              //_addDateBar(),
              //ProfileTab(),
              //Icon(Icons.cancel_outlined, size: 100, color: Colors.red),
              //SizedBox(height: 20),
              // Expanded(child: GetBuilder<CancelledTaskController>(
              //     builder: (cancelledTaskController) {
              //   return Visibility(
              //     visible: cancelledTaskController.getCancelledTask == false,
              //     replacement: Center(
              //       child: CircularProgressIndicator(),
              //     ),
              //     child: RefreshIndicator(
              //       child: ListView.builder(
              //           physics: BouncingScrollPhysics(),
              //           itemCount: cancelledTaskController
              //                   .taskListModel.taskList?.length ??
              //               0,
              //           itemBuilder: (context, index) {
              //             return TaskItemCard(
              //               task: cancelledTaskController
              //                   .taskListModel.taskList![index],
              //               onStatusChange: () {
              //                 cancelledTaskController.getCancelledTaskList();
              //               },
              //               showProgress: (inProgress) {},
              //             );
              //           }),
              //       onRefresh: () =>
              //           cancelledTaskController.getCancelledTaskList(),
              //     ),
              //   );
              // })),
            ],
          ),
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
