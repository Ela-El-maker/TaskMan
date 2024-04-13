import 'package:flutter/material.dart';

import '../../models/TaskModels/taskCountModel.dart';
import '../../widgets/cards.dart';

class TaskDetails extends StatefulWidget {
  final Task? task;

  const TaskDetails({Key? key, this.task}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Task Details'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task?.title ?? 'No Title',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(widget.task?.description ?? 'No Description'),
                    SizedBox(height: 8),
                    
                  ],
                ),
              ),
              actions: <Widget>[],
            );
          },
        );
      }, // Replace YourCardWidget with your actual card widget
    );
  }
}
